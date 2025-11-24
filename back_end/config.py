from dotenv import load_dotenv
import os

load_dotenv()
DB_URL = os.getenv("DB_URL")
SECRET_KEY = os.getenv("SECRET_KEY")
ALGORITHM = "HS256"