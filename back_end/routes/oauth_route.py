from fastapi import APIRouter, Depends, Request
from sqlalchemy.ext.asyncio import AsyncSession
from db.database import get_db

from services.oauth import (
    google_start,
    google_callback
)
router = APIRouter(prefix="/auth/google", tags=["Google OAuth"])

@router.get("/start")
async def google_oauth_start():
    return await google_start()

@router.get("/callback")
async def google_oauth_callback(
    request: Request,
    db: AsyncSession = Depends(get_db)
):
    return await google_callback(request, db)


