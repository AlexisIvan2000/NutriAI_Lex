from fastapi import APIRouter, Depends, Request
from sqlalchemy.ext.asyncio import AsyncSession
from services.oauth import google_login, google_callback
from db.database import get_db

router = APIRouter(prefix="/auth", tags=["OAuth"])

@router.get("/google/login")
async def google_oauth_login():
    return await google_login()

@router.get("/google/auth")
async def google_oauth_callback(request: Request, db: AsyncSession = Depends(get_db)):
    return await google_callback(request, db)

