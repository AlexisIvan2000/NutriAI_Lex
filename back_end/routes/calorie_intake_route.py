from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from services.calorie_intake import save_calorie_intake
from services.nutrition import calculate_nutrition
from db.schemas import NutritionInput
from db.database import get_db

router = APIRouter(prefix="/calories", tags=["Calories"])

@router.post("/generate/{user_id}")
async def generate_calorie_intake(user_id: int, data: NutritionInput, db: AsyncSession = Depends(get_db)):
    nutrition = calculate_nutrition(data)
    saved = await save_calorie_intake(user_id, nutrition, db)
    return {"message": "Saved", "data": saved}
