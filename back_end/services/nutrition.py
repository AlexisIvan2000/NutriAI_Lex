from db.schemas import NutritionInput, NutritionOutput
from db.models import CalorieIntake
from sqlalchemy.ext.asyncio import AsyncSession


def calculate_bmr(input: NutritionInput) -> float:
    if input.gender.lower() == 'male':
        return 10 * input.weight + 6.25 * input.height - 5 * input.age + 5
    else:
        return 10 * input.weight + 6.25 * input.height - 5 * input.age - 161
    

def activity_factor(level: str) -> float:
    level = level.lower()
    if level == 'sedentary':
        return 1.2
    if level == 'lightly active':
        return 1.375
    if level == 'moderately active':
        return 1.55
    if level == 'very active':
        return 1.725
    return 1.2  


def goal_adjustment(goal: str) -> float:
    goal = goal.lower()
    if goal == 'lose fat':
        return -500
    if goal == 'mass gain':
        return 500
    return 0 


def calculate_nutrition(input: NutritionInput) -> NutritionOutput:
    bmr = calculate_bmr(input)
    tdee_base = bmr * activity_factor(input.activity_level)
    tdee = tdee_base + goal_adjustment(input.goal)

    if input.goal.lower() == 'lose fat':
        proteins = (0.35 * tdee) / 4
        carbs = (0.40 * tdee) / 4
        fats = (0.25 * tdee) / 9
    elif input.goal.lower() == 'mass gain':
        proteins = (0.50 * tdee) / 4
        carbs = (0.30 * tdee) / 4
        fats = (0.20 * tdee) / 9
    else: 
        proteins = (0.30 * tdee) / 4
        carbs = (0.45 * tdee) / 4
        fats = (0.25 * tdee) / 9

    return NutritionOutput(
        bmr=round(bmr, 2),
        tdee=round(tdee, 2),
        proteins=round(proteins, 2),
        fats=round(fats, 2),
        carbs=round(carbs, 2)
    )
