from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from db.database import get_db
from services.ai import generate_weekly_nutrition_plan
from services.auth import get_current_user

router = APIRouter(prefix="/ai", tags=["AI Nutrition"])

@router.post("/weekly-plan")
async def generate_plan(
    db: AsyncSession = Depends(get_db),
    current_user = Depends(get_current_user)
):
    plan, error = await generate_weekly_nutrition_plan(current_user.id, db)

    if error:
        return {"success": False, "message": error}

    return {"success": True, "plan": plan}
