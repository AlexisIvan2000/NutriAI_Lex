from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select

from db.database import get_db
from db.models import User, PersonalDetails, CalorieIntake
from services.nutrition import calculate_nutrition
from services.auth import get_current_user


router = APIRouter(prefix="/nutrition", tags=["Nutrition"])

@router.get("/summary")
async def get_nutrition_summary(current_user: User = Depends(get_current_user), db: AsyncSession = Depends(get_db)):    
    result = await db.execute(
        select(PersonalDetails).where(PersonalDetails.user_id == current_user.id)
    )
    details = result.scalars().first()

    if not details:
        raise HTTPException(
            status_code=404,
            detail="Personal details not found. Please complete your profile."
        )

   
    nutrition = calculate_nutrition(details)

    
    intake = CalorieIntake(
        user_id=current_user.id,
        calorie_amount=nutrition.tdee,
        carbs=nutrition.carbs,
        proteins=nutrition.proteins,
        fats=nutrition.fats,
    )

    db.add(intake)
    await db.commit()
    return nutrition

@router.put("/update")
async def update_calorie_intake(data: dict, current_user = Depends(get_current_user), db: AsyncSession = Depends(get_db)):
    result = await db.execute(select(CalorieIntake).where(CalorieIntake.user_id == current_user.id))
    intake = result.scalars().first()

    if not intake:
        intake = CalorieIntake(
            user_id=current_user.id,
            calorie_amount=data["calories"],
            proteins=data["proteins"],
            carbs=data["carbs"],
            fats=data["fats"]
        )
        db.add(intake)
    else:
        intake.calorie_amount = data["calories"]
        intake.proteins = data["proteins"]
        intake.carbs = data["carbs"]
        intake.fats = data["fats"]

    await db.commit()
    return {"message": "Calorie intake updated successfully"}
