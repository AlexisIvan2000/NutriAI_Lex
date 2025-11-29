from config import OPENAI_API_KEY
from openai import OpenAI
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from db.models import PersonalDetails, CalorieIntake, DietAllergy, NutritionPlan
import json

client = OpenAI(api_key=OPENAI_API_KEY)

async def generate_weekly_nutrition_plan(user_id: int, db: AsyncSession):

    pd = (await db.execute(select(PersonalDetails).where(PersonalDetails.user_id == user_id))).scalars().first()
    ci = (await db.execute(select(CalorieIntake).where(CalorieIntake.user_id == user_id))).scalars().first()
    da = (await db.execute(select(DietAllergy).where(DietAllergy.user_id == user_id))).scalars().first()

    if not pd or not ci:
        return None, "Insufficient data to generate plan."

    allergies = json.loads(da.allergies) if da and da.allergies else []

    prompt = f"""
    Create a weekly nutrition plan …

    Daily calories: {ci.calorie_amount}
    Proteins: {ci.proteins} g
    Carbs: {ci.carbs} g
    Fats: {ci.fats} g
    Diet: {da.diet if da else "No preference"}
    Allergies: {", ".join(allergies) if allergies else "None"}

    Return a valid JSON with days, meals, ingredients, grams.
    """

    response = client.chat.completions.create(
        model="gpt-4o-mini",
        response_format={"type": "json_object"},
        messages=[{"role": "user", "content": prompt}],
        max_tokens=3000
    )

    content = response.choices[0].message.content

   
    if isinstance(content, dict):
        parsed = content
    else:
        try:
            parsed = json.loads(content)
        except Exception:
            print("JSON ERROR:", content)
            return None, "Failed to parse AI response."

    new_plan = NutritionPlan(
        user_id=user_id,
        plan_text=json.dumps(parsed)
    )
    db.add(new_plan)
    await db.commit()

    return parsed, None

