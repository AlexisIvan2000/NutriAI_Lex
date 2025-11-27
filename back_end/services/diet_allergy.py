import json
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from db.models import DietAllergy

async def save_diet_allergy(data, user_id: int, db: AsyncSession):
    result = await db.execute(
        select(DietAllergy).where(DietAllergy.user_id == user_id)
    )
    entry = result.scalars().first()

    allergies_json = json.dumps(data.allergies)

    if entry:
        entry.diet = data.diet
        entry.allergies = allergies_json
    else:
        entry = DietAllergy(
            user_id=user_id,
            diet=data.diet,
            allergies=allergies_json,
        )
        db.add(entry)

    await db.commit()
    await db.refresh(entry)

    return entry


async def get_diet_allergy(user_id: int, db: AsyncSession):
    result = await db.execute(
        select(DietAllergy).where(DietAllergy.user_id == user_id)
    )
    entry = result.scalars().first()

    if not entry:
        return {"diet": "No Preference", "allergies": []}

    return {
        "diet": entry.diet,
        "allergies": json.loads(entry.allergies)
    }
