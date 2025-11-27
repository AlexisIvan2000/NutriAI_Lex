from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from db.models import DietAllergy

async def save_diet_allergy(user_id: int, data, db: AsyncSession):
    query = await db.execute(
        select(DietAllergy).where(DietAllergy.user_id == user_id)
    )
    entry = query.scalar_one_or_none()

    if entry:
        entry.diet = data.diet
        entry.allergies = data.allergies
    else:
        entry = DietAllergy(
            user_id=user_id,
            diet=data.diet,
            allergies=data.allergies
        )
        db.add(entry)

    await db.commit()
    await db.refresh(entry)

    return entry


async def get_diet_allergy(user_id: int, db: AsyncSession):
    query = await db.execute(
        select(DietAllergy).where(DietAllergy.user_id == user_id)
    )
    return query.scalar_one_or_none()
