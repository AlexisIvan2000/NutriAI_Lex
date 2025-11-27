from sqlalchemy.ext.asyncio import AsyncSession
from db.models import CalorieIntake

async def save_calorie_intake(user_id: int, data, db: AsyncSession):
    record = CalorieIntake(
        user_id=user_id,
        calorie_amount=data.tdee,
        carbs=data.carbs,
        proteins=data.proteins,
        fats=data.fats
    )

    db.add(record)
    await db.commit()    
    return record

