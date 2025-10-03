# 🚀 Guide de déploiement ERPNext GRATUIT

## 🎯 Résumé des options

| Option | Coût | Complexité | Accès | Base de données |
|--------|------|------------|-------|-----------------|
| **Railway** | GRATUIT | ⭐⭐ | Internet | Incluse |
| **Local Docker** | GRATUIT | ⭐⭐⭐ | Local | Incluse |
| **Local complet** | GRATUIT | ⭐⭐⭐⭐ | Local | Manuel |

## 🏆 RECOMMANDATION : Railway (Option 1)

### Pourquoi Railway ?
- ✅ **100% GRATUIT** à vie
- ✅ Base de données PostgreSQL incluse
- ✅ Déploiement en 5 minutes
- ✅ HTTPS automatique
- ✅ Sauvegarde automatique
- ✅ Accessible depuis n'importe où

### Étapes Railway :
1. **Créer compte** : [railway.app](https://railway.app)
2. **Connecter GitHub** : Sélectionner ce repository
3. **Déployer** : Railway fait tout automatiquement
4. **Accéder** : URL fournie par Railway

---

## 🖥️ Option 2 : Installation locale

### Pour installation locale uniquement :
1. **Installer Docker Desktop**
2. **Double-cliquer** sur `start-erpnext.bat`
3. **Attendre 5 minutes**
4. **Ouvrir** http://localhost:8000

### Avantages local :
- ✅ Fonctionne hors ligne
- ✅ Données 100% privées
- ✅ Pas de limite

---

## 🔧 Configuration base de données

### Railway (Automatique) :
- **Type** : PostgreSQL
- **Host** : Automatique
- **Utilisateur** : Automatique
- **Mot de passe** : Automatique
- **Base** : erpnext

### Local (Manuel) :
- **Type** : MariaDB
- **Host** : localhost:3306
- **Utilisateur** : erpnext
- **Mot de passe** : admin
- **Base** : erpnext

---

## 🚀 Démarrage rapide

### Railway (Recommandé) :
```bash
# 1. Aller sur railway.app
# 2. Se connecter avec GitHub
# 3. Sélectionner ce repository
# 4. Attendre le déploiement
# 5. Accéder à l'URL fournie
```

### Local :
```bash
# 1. Installer Docker Desktop
# 2. Double-cliquer start-erpnext.bat
# 3. Attendre 5 minutes
# 4. Ouvrir http://localhost:8000
```

---

## 🔑 Connexion ERPNext

- **URL** : (Railway URL) ou http://localhost:8000
- **Utilisateur** : Administrator
- **Mot de passe** : admin

---

## 📞 Support

Si vous avez des problèmes :
1. **Railway** : Vérifier les logs dans Railway dashboard
2. **Local** : Vérifier que Docker fonctionne
3. **Base de données** : Vérifier les variables d'environnement

---

## 🎉 Félicitations !

Votre ERPNext est maintenant déployé et prêt à l'emploi !
