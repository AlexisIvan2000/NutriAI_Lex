import pytest
import respx
from httpx import Response
from services.jwt_handler import verify_access_token


@pytest.mark.asyncio
@respx.mock(assert_all_called=False)
async def test_google_callback(client):

    respx.post(
        url__regex=r"https://oauth2\.googleapis\.com/token.*"
    ).mock(
        return_value=Response(
            200,
            json={
                "access_token": "fake-google-token",
                "expires_in": 3600
            }
        )
    )

    respx.get(
        url__regex=r"https://www\.googleapis\.com/oauth2/v2/userinfo.*"
    ).mock(
        return_value=Response(
            200,
            json={
                "email": "google@test.com",
                "id": "123456789",
                "given_name": "Google",
                "family_name": "Tester"
            }
        )
    )
    response = await client.get("/auth/google/auth?code=fake-code")
