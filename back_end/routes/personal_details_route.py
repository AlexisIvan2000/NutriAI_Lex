
from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select

from db.database import get_db

from services.personal_details import save_personal_details
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

