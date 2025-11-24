from fastapi import FastAPI
from routes import router as auth_route
from db.database import Base, engine

app = FastAPI()
Base.metadata.create_all(bind=engine)
app.include_router(auth_route)

@app.get("/")
async def root():
    return {"message": "Welcome to the NutriAI Lex API"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)