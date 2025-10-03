# 🚀 Déploiement ERPNext sur Railway (GRATUIT)

## Étapes de déploiement :

### 1. Préparer le projet
```bash
# Cloner ce repository
git clone [votre-repo]
cd ProLogiciel
```

### 2. Créer un compte Railway
1. Aller sur [railway.app](https://railway.app)
2. Se connecter avec GitHub
3. Cliquer sur "New Project"
4. Sélectionner "Deploy from GitHub repo"

### 3. Configuration Railway
1. Sélectionner votre repository
2. Railway détectera automatiquement le Dockerfile
3. Ajouter les variables d'environnement :
   - `DB_HOST`: (Railway fournira automatiquement)
   - `DB_PASSWORD`: (Railway générera automatiquement)
   - `DB_USER`: (Railway générera automatiquement)
   - `DB_NAME`: erpnext

### 4. Base de données
Railway fournit automatiquement :
- PostgreSQL (gratuit jusqu'à 1GB)
- Variables d'environnement automatiques

### 5. Déploiement
1. Railway déploiera automatiquement
2. Attendre 5-10 minutes
3. Votre ERPNext sera accessible via l'URL fournie

## Avantages Railway :
- ✅ **100% GRATUIT** (plan gratuit généreux)
- ✅ Base de données incluse
- ✅ Déploiement automatique
- ✅ HTTPS automatique
- ✅ Sauvegarde automatique

## URL d'accès :
Une fois déployé, vous recevrez une URL comme :
`https://votre-projet.railway.app`

## Connexion :
- **URL** : Votre URL Railway
- **Utilisateur** : Administrator
- **Mot de passe** : admin (par défaut)
