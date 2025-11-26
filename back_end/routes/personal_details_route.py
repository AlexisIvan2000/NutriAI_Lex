
from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select

from db.database import get_db

from services.personal_details import save_personal_details, get_personal_details
from db.schemas import PersonalDetailsCreate

router = APIRouter(prefix="/personal-details", tags=["Personal Details"])

@router.post("/save")
async def save_route(
    data: PersonalDetailsCreate,
    db: AsyncSession = Depends(get_db)
):
    saved = await save_personal_details(data, db)
    return {
        "success": True,
        "message": "Personal details saved successfully",
        "data": saved
    }

@router.get("/get/{user_id}")
async def get_route(
    user_id: int,
    db: AsyncSession = Depends(get_db)
):
    details = await get_personal_details(user_id, db)
    if details:
        return {
            "success": True,
            "data": details
        }
    else:
        return {
            "success": False,
            "message": "Personal details not found"
        }