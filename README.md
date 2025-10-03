# ERPNext Déployable

Ce projet contient une configuration ERPNext prête pour le déploiement.

## 🚀 Déploiement local

### Prérequis
- Docker Desktop
- Git

### Installation
```bash
git clone https://github.com/Floop2Gare/ProLogiciel.git
cd ProLogiciel
docker compose -f dev-pwd.yml up -d
```

### Accès
- URL: http://localhost:8080
- Utilisateur: Administrator
- Mot de passe: admin

## 🌐 Déploiement sur Railway

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/template/your-template)

### Configuration Railway
1. Connectez votre repo GitHub à Railway
2. Railway détectera automatiquement la configuration Docker
3. Configurez les variables d'environnement :
   - `DB_HOST`: Votre base de données PostgreSQL Railway
   - `DB_NAME`: Nom de votre base de données
   - `DB_USER`: Utilisateur de la base
   - `DB_PASSWORD`: Mot de passe de la base

## 📱 Accès multi-plateforme

- ✅ Windows (local)
- ✅ Mac (local ou Railway)
- ✅ Linux (local ou Railway)
- ✅ Mobile (via Railway)

## 🔧 Personnalisation

Modifiez les fichiers dans le dossier `erpnext-develop` pour personnaliser votre ERP.

## 📞 Support

Pour toute question, ouvrez une issue sur ce repo.