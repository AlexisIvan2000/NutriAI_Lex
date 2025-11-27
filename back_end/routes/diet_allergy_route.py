from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from db.database import get_db
from services.diet_allergy import save_diet_allergy, get_diet_allergy
from db.schemas import DietAllergyInput
from services.auth import get_current_user

router = APIRouter(prefix="/diet-allergy", tags=["Diet & Allergies"])

@router.post("/save")
async def save_route(
    data: DietAllergyInput,
    db: AsyncSession = Depends(get_db),
    current_user = Depends(get_current_user),
):
    result = await save_diet_allergy(current_user.id, data, db)
    return {"success": True, "data": result}

@router.get("/get")
async def get_route(
    db: AsyncSession = Depends(get_db),
    current_user = Depends(get_current_user),
):
    result = await get_diet_allergy(current_user.id, db)
    return {"success": True, "data": result}
