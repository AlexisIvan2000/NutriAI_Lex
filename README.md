# NutriAI_Lex (Complete Nutrtition Management App)
NutriAI_Lex est une application mobile moderne construite avec FastAPI, Flutter, PostgreSQL, OpenAI permettant aux utilisateurs de gérer leurs données nutritionnelles, générer des plans alimentaires personnalisés grâce à OpenAI, consulter des conseils santé, rechercher des aliments via une API externe, et exporter leurs plans au format PDF.
Ce projet illustre une architecture complète mobile + backend + base de données, conçue pour être robuste, extensible et sécurisée.

## Fonctionnalités principales
### Authentification 
- Inscription + connexion via email/mot de passe
-  Authentification avec Google
-  Backend gère le hashing Argon2 + JWT
-  Token stocké côté application pour appels sécurisés

### Gestion des informations personnelles 
