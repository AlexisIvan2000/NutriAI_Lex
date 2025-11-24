import pytest
from fastapi.testclient import TestClient
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

from main import app
from db.database import Base, get_db

TEST_DB_URL = "sqlite:///./test.db"

engine = create_engine(
    TEST_DB_URL, connect_args={"check_same_thread": False}
)
TestingSessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base.metadata.create_all(bind=engine)


def override_get_db():
    db = TestingSessionLocal()
    try:
        yield db
    finally:
        db.close()


app.dependency_overrides[get_db] = override_get_db
client = TestClient(app)


@pytest.fixture
def token():
    client.post(
        "/auth/register",
        json={
            "first_name": "John",
            "last_name": "Doe",
            "email": "johndoe@gmail.com",
            "password": "test1234"
        }
    )
    response = client.post(
        "/auth/login",
        json={
            "email": "johndoe@gmail.com",
            "password": "test1234"
        }
    )

    assert response.status_code == 200
    return response.json()["access_token"]

def test_register_user():
    response = client.post(
        "/auth/register",
        json={
            "first_name": "Alice",
            "last_name": "Smith",
            "email": "alice@test.com",
            "password": "password"
        }
    )
    assert response.status_code == 200
    assert response.json()["message"] == "User registered successfully"

def test_login_user():
    response = client.post(
        "/auth/login",
        json={
            "email": "johndoe@gmail.com",
            "password": "test1234"
        }
    )

    assert response.status_code == 200
    assert "access_token" in response.json()

def test_get_current_user(token):
    response = client.get(
        "/auth/me",
        headers={"Authorization": f"Bearer {token}"}
    )

    assert response.status_code == 200
    assert response.json()["email"] == "johndoe@gmail.com"
