from fastapi import Depends, HTTPException, Request
from fastapi.responses import RedirectResponse, HTMLResponse
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from db.database import get_db
from db.models import User
from services.jwt_handler import create_access_token

from config import (
    GOOGLE_CLIENT_ID, 
    GOOGLE_CLIENT_SECRET, 
    GOOGLE_REDIRECT_URI
)
import httpx
GOOGLE_AUTH_URL = "https://accounts.google.com/o/oauth2/v2/auth"
GOOGLE_TOKEN_URL = "https://oauth2.googleapis.com/token"
GOOGLE_USERINFO_URL = "https://www.googleapis.com/oauth2/v2/userinfo"

async def google_login():
    auth_url = (
        f"{GOOGLE_AUTH_URL}"
        f"?response_type=code"
        f"&client_id={GOOGLE_CLIENT_ID}"
        f"&redirect_uri={GOOGLE_REDIRECT_URI}"
        f"&scope=openid%20email%20profile"
        f"&access_type=offline"
        f"&prompt=consent"
    )
    return RedirectResponse(auth_url, status_code=302)

async def google_callback(request: Request,db: AsyncSession = Depends(get_db)):
    try:
        code = request.query_params.get("code")
        if not code:
            raise HTTPException(
                status_code=400,
                detail="Authorization code missing"
            )    
        async with httpx.AsyncClient() as client:
            token_response = await client.post(
                GOOGLE_TOKEN_URL,
                data={
                    "code": code,
                    "client_id": GOOGLE_CLIENT_ID,
                    "client_secret": GOOGLE_CLIENT_SECRET,
                    "redirect_uri": GOOGLE_REDIRECT_URI,
                    "grant_type": "authorization_code",
                }
            )
        token_json = token_response.json()
        access_token = token_json.get("access_token")
        if not access_token:
            raise HTTPException(
                status_code=400,
                detail="Could not obtain access_token from Google"
            )
        async with httpx.AsyncClient() as client:
            userinfo_res = await client.get(
                GOOGLE_USERINFO_URL,
                headers={"Authorization": f"Bearer {access_token}"}
            )

        profile = userinfo_res.json()

        email = profile.get("email")
        google_id = profile.get("id") or profile.get("sub")
        first_name = profile.get("given_name", "")
        last_name = profile.get("family_name", "")

        if not email or not google_id:
            raise HTTPException(
                status_code=400,
                detail="Failed to retrieve user info from Google"
            )

    
        result = await db.execute(select(User).where(User.email == email))
        user = result.scalars().first()

        if user:            
            user.provider = "google"
            user.provider_id = google_id
        else:
            user = User(
                email=email,
                first_name=first_name,
                last_name=last_name,
                provider="google",
                provider_id=google_id,
            )
            db.add(user)
        await db.commit()
        await db.refresh(user)
        jwt_token = create_access_token({
            "sub": user.email,
            "user_id": user.id
        })
      
        html = f"""
        <html>
        <body>
            <script>
                window.flutter_inappwebview.callHandler('googleLogin', "{jwt_token}");
            </script>
            <p>You can now close this window.</p>
        </body>
        </html>
        """
        return HTMLResponse(content=html)

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
