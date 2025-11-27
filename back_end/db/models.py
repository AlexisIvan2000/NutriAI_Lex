from sqlalchemy import Column, Integer, String,Float, DateTime,ForeignKey, func
from sqlalchemy.orm import relationship
from .database import Base

class User(Base):
    __tablename__ = 'users'

    id = Column(Integer, primary_key=True, index=True)
    first_name = Column(String(50), nullable=False)
    last_name = Column(String(50), nullable=False)
    email = Column(String(120), unique=True, index=True, nullable=False)
    password = Column(String, nullable=False)
    
    provider = Column(String, default='local')
    provider_id = Column(String, nullable=True)
    oauth_token = Column(String, nullable=True)
    
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), server_default=func.now(), onupdate=func.now())

    personal_details = relationship("PersonalDetails", back_populates="user", uselist=False, cascade="all, delete, delete-orphan")
    calorie_intakes = relationship("CalorieIntake", back_populates="user", cascade="all, delete, delete-orphan")
    nutrition_plans = relationship("NutritionPlan", back_populates="user", cascade="all, delete, delete-orphan")
    diet_allergies = relationship("DietAllergy", back_populates="user", cascade="all, delete, delete-orphan")

class PersonalDetails(Base):
  __tablename__ = 'personal_details'

  id = Column(Integer, primary_key=True, index=True)
  user_id = Column(Integer, ForeignKey('users.id',ondelete="CASCADE"), nullable=False)
  age = Column(Integer, nullable=True)
  weight = Column(Float, nullable=True)  
  height = Column(Float, nullable=True) 
  gender = Column(String(10), nullable=True)
  activity_level = Column(String(50), nullable=True) 
  goal = Column(String(50), nullable=True) 

  user = relationship("User", back_populates="personal_details")

class CalorieIntake(Base):
  __tablename__ = 'calorie_intake'

  id = Column(Integer, primary_key=True, index=True)
  user_id = Column(Integer, ForeignKey('users.id', ondelete='CASCADE'), nullable=False)
  calorie_amount = Column(Integer, nullable=False)
  carbs = Column(Integer, nullable=True)
  proteins = Column(Integer, nullable=True)
  fats = Column(Integer, nullable=True)

  user = relationship("User", back_populates="calorie_intakes")

class NutritionPlan(Base):
  __tablename__ = 'nutrition_plans'

  id = Column(Integer, primary_key=True, index=True)
  user_id = Column(Integer, ForeignKey('users.id', ondelete='CASCADE'), nullable=False)
  plan_text = Column(String, nullable=False)
  created_at = Column(DateTime(timezone=True), server_default=func.now())

  user = relationship("User", back_populates="nutrition_plans")


class DietAllergy(Base):
    __tablename__ = "diet_allergies"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"), nullable=False)
    diet = Column(String(100), nullable=True)        
    allergies = Column(String(500), nullable=True)   
    user = relationship("User", back_populates="diet_allergies")

  