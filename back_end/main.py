from fastapi import FastAPI
from routes.auth_route import router as auth_route
from routes.oauth_route import router as oauth_route
from routes.personal_details_route import router as personal_details_route
from routes.nutrition_route import router as nutrition_route
from routes.calorie_intake_route import router as calorie_intake_route
app = FastAPI()

app.include_router(auth_route)
app.include_router(oauth_route)
app.include_router(personal_details_route)
app.include_router(nutrition_route)
app.include_router(calorie_intake_route)
@app.get("/")
async def root():
    return {"message": "Welcome to the NutriAI Lex API"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="127.0.0.1", port=8000, reload=True)
