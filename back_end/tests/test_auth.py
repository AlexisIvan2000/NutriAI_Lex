import pytest

@pytest.mark.asyncio
async def test_register_user(client):
    response = await client.post(
        "/auth/register",
        json={
            "first_name": "John",
            "last_name": "Doe",
            "email": "john@test.com",
            "password": "123456"
        }
    )
    assert response.status_code == 200


@pytest.mark.asyncio
async def test_login_user(client):
    response = await client.post(
        "/auth/login",
        json={
            "email": "john@test.com",
            "password": "123456"
        }
    )
    assert response.status_code == 200
    global token
    token = response.json()["access_token"]


@pytest.mark.asyncio
async def test_get_current_user(client):
    response = await client.get(
        "/auth/me",
        headers={"Authorization": f"Bearer {token}"}
    )
    assert response.status_code == 200
    assert response.json()["email"] == "john@test.com"

