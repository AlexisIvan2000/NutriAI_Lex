from fastapi import APIRouter
from db.schemas import NutritionInput, NutritionOutput
from services.nutrition import calculate_nutrition

router = APIRouter(prefix="/nutrition", tags=["Nutrition"])

@router.post("/calculate", response_model=NutritionOutput)
async def calculate_nutrition_route(data: NutritionInput):
    result = calculate_nutrition(data)
    return result

