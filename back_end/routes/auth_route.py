from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from services.auth import register_user, login_user, get_current_user
from db.database import get_db
from db.schemas import UserCreate, UserLogin

router = APIRouter(prefix="/auth", tags=["Authentication"])

@router.post("/register")
async def register(user: UserCreate, db: Session = Depends(get_db)):
    return await register_user(user, db)

@router.post("/login")
async def login(user: UserLogin, db: Session = Depends(get_db)):
    return await login_user(user, db)

@router.get("/me")
async def read_current_user(current_user=Depends(get_current_user)):
    return current_user

@router.get("/protected")
async def protected_route(current_user=Depends(get_current_user)):
    return {"message": "You are authenticated", "user": current_user}