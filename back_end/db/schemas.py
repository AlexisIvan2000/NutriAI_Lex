from pydantic import BaseModel, EmailStr

# User Schemas
class UserCreate(BaseModel):
   first_name: str
   last_name: str
   email: EmailStr
   password: str


class UserLogin(BaseModel):
   email: EmailStr
   password: str


class UserBase(BaseModel):
   id: int
   first_name: str
   last_name: str
   email: EmailStr


   class Config:
      orm_mode = True



# Personal Details Schemas
class PersonalDetailsCreate(BaseModel):
   user_id: int
   age: int
   weight: float
   height: float
   gender: str
   activity_level: str
   goal: str

   class Config:
      orm_mode = True


class NutritionInput(BaseModel):
   age: int
   weight: float
   height: float
   gender: str
   activity_level: str
   goal: str


class NutritionOutput(BaseModel):
  bmr: float
  tdee: float
  proteins: float
  fats: float
  carbs: float

  class Config:
      orm_mode = True
  

# AI Nutrition Plan Response Schema
class AINutritionPlanResponse(BaseModel):
   plan_text: str

  
   