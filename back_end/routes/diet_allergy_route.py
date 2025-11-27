from fastapi import APIRouter, Depends
from pydantic import BaseModel
from sqlalchemy.ext.asyncio import AsyncSession
from db.database import get_db
from services.diet_allergy import save_diet_allergy, get_diet_allergy
from services.auth import get_current_user

class DietAllergyInput(BaseModel):
    diet: str
    allergies: list[str]

router = APIRouter(prefix="/diet-allergy", tags=["Diet & Allergy"])

@router.post("/save")
async def save(data: DietAllergyInput, user=Depends(get_current_user), db: AsyncSession = Depends(get_db)):
    entry = await save_diet_allergy(data, user.id, db)
    return {"success": True, "data": {"diet": entry.diet, "allergies": data.allergies}}

@router.get("/get")
async def get(user=Depends(get_current_user), db: AsyncSession = Depends(get_db)):
    data = await get_diet_allergy(user.id, db)
    return {"success": True, "data": data}
