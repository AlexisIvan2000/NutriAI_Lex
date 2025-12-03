# NutriAI_Lex 
NutriAI_Lex est une application mobile moderne construite avec FastAPI, Flutter, PostgreSQL, OpenAI permettant aux utilisateurs de gérer leurs données nutritionnelles, générer des plans alimentaires personnalisés grâce à OpenAI, consulter des conseils santé, rechercher des aliments via une API externe, et exporter leurs plans au format PDF.
Ce projet illustre une architecture complète mobile + backend + base de données, conçue pour être robuste, extensible et sécurisée.

## Fonctionnalités principales
### Authentification 
- Inscription + connexion via email/mot de passe
-  Authentification avec Google
-  Backend gère le hashing Argon2 + JWT
-  Token stocké côté application pour appels sécurisés
-  Stockage en base PostgreSQL (table users)

###  Données personnelles et calculs
 - Saisie de l'age, poids, taille, genre, objectif
 - Calcul automatique de la TDEE et répartition des nutriments
 - Stockage en base PostgreSQL (tables personal_details et calorie_intake)

### Plan nutritionnel hebdomadaire (OpenAI)
- Génération automatique d'un plan  nutritonnel de 7 jours  basé sur l'objectif, les allergies, régime alimentaire (keto, vegan, etc.)
- Export du plan hebdomadaire en PDF
- Mise en page propre + listes d'ingrédients et grammages
- Sauvegarde en base (nutrition_plans)

### Recherche alimentaire (API externe)
Recherche de recettes via API gratuite

## Architecture Backend
### Technos utilisés
 - #### FastAPI (Python)
 - #### PostgreSQL
 - #### SQLAlchemy (async)
 - #### OpenAI
### Tables principales et relations
 - #### users 1--1 personal_details
 - #### users 1--N calorie_intake
 - #### users 1--1 diet_allergy
 - #### users 1--N nutrition_plans
### API CRUD
 - #### CRUD complet: user, détails personnels, allergies, calories, plans
 - #### EndPoints sécurisés par JWT
 - #### Génération du plan nutritionnel

## FrontEnd (Flutter)
- #### Appels API via http
- #### Navigation avec BottomNavigationBar



