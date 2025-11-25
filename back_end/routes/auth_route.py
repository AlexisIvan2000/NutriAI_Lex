from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession

from services import auth
from services.auth import register_user, login_user, get_current_user, logout_user, reset_password
from db.database import get_db
from db.schemas import UserCreate, UserLogin

router = APIRouter(prefix="/auth", tags=["Authentication"])


@router.post("/register")
async def register(user: UserCreate, db: AsyncSession = Depends(get_db)):
    return await register_user(user, db)


@router.post("/login")
async def login(user: UserLogin, db: AsyncSession = Depends(get_db)):
    return await login_user(user, db)


@router.get("/me")
async def read_current_user(current_user = Depends(get_current_user)):
    return current_user


@router.get("/protected")
async def protected_route(current_user = Depends(get_current_user)):
    return {"message": "You are authenticated", "user": current_user}

@router.post("/logout")
async def logout():
    return await logout_user()

@router.post("/reset-password")
async def reset_password_route(data: dict, db: AsyncSession = Depends(get_db)):
    return await reset_password(data, db)
