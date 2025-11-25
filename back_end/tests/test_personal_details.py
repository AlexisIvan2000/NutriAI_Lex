import pytest
from httpx import AsyncClient
from sqlalchemy import select
from sqlalchemy import text


from main import app
from db.database import get_db
from db.models import User, PersonalDetails
from tests.conftest import override_get_db

@pytest.mark.asyncio
async def test_save_personal_details(client):

    async for db in override_get_db():

      
        await db.execute(text("DELETE FROM users"))
        await db.commit()

        user = User(
            first_name="John",
            last_name="Doe",
            email="john@test.com",
            password="hashed_pw"
        )
        db.add(user)
        await db.commit()
        await db.refresh(user)

       
        response = await client.post("/personal-details/save", json={
            "user_id": user.id,
            "age": 25,
            "weight": 70,
            "height": 180,
            "gender": "male",
            "activity_level": "active",
            "goal": "maintenance",
        })

        assert response.status_code == 200
        data = response.json()
        assert data["age"] == 25
