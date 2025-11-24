import pytest
import pytest_asyncio
import asyncio
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.orm import sessionmaker
from httpx import AsyncClient, ASGITransport

from main import app
from db.database import Base, get_db

TEST_DB_URL = "sqlite+aiosqlite:///./test.db"

engine_test = create_async_engine(TEST_DB_URL, future=True, echo=False)

TestingSessionLocal = sessionmaker(
    bind=engine_test,
    expire_on_commit=False,
    class_=AsyncSession
)

async def override_get_db():
    async with TestingSessionLocal() as session:
        yield session

@pytest.fixture(scope="session")
def event_loop():
    loop = asyncio.new_event_loop()
    yield loop
    loop.close()

@pytest.fixture(scope="session", autouse=True)
def setup_test_db(event_loop):
    async def create():
        async with engine_test.begin() as conn:
            await conn.run_sync(Base.metadata.create_all)

    async def drop():
        async with engine_test.begin() as conn:
            await conn.run_sync(Base.metadata.drop_all)

    event_loop.run_until_complete(create())
    yield
    event_loop.run_until_complete(drop())


@pytest_asyncio.fixture
async def client():
    app.dependency_overrides[get_db] = override_get_db

    transport = ASGITransport(app=app)
    async with AsyncClient(transport=transport, base_url="http://test") as ac:
        yield ac
