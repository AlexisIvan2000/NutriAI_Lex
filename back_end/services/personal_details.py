from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from db.models import PersonalDetails

async def save_personal_details(data, db: AsyncSession):
    existing = await db.execute(
        select(PersonalDetails).where(PersonalDetails.user_id == data.user_id)
    )
    details = existing.scalars().first()

    if details:
        for field, value in data.dict().items():
            setattr(details, field, value)
    else:
        details = PersonalDetails(**data.dict())
        db.add(details)

    await db.commit()
    await db.refresh(details)

    return details

async def get_personal_details(user_id: int, db: AsyncSession):
    result = await db.execute(
        select(PersonalDetails).where(PersonalDetails.user_id == user_id)
    )
    details = result.scalars().first()
    return details