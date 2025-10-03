# 💻 Installation locale ERPNext avec base de données

## Option A : Installation complète locale

### Prérequis :
- Windows 10/11
- 8GB RAM minimum
- 20GB espace disque

### 1. Installer les dépendances
```bash
# Installer Python 3.11
# Télécharger depuis python.org

# Installer Node.js 18+
# Télécharger depuis nodejs.org

# Installer Git
# Télécharger depuis git-scm.com
```

### 2. Installer MariaDB (Base de données)
```bash
# Télécharger MariaDB depuis mariadb.org
# Installer avec mot de passe root : admin
```

### 3. Installer ERPNext
```bash
# Ouvrir PowerShell en tant qu'administrateur
pip install frappe-bench

# Créer un nouveau site
bench init frappe-bench --frappe-branch version-15
cd frappe-bench

# Installer ERPNext
bench get-app erpnext --branch version-15

# Créer un nouveau site
bench new-site erpnext.localhost --admin-password admin --db-root-password admin

# Installer ERPNext sur le site
bench --site erpnext.localhost install-app erpnext

# Démarrer le serveur
bench start
```

### 4. Accès
- **URL** : http://localhost:8000
- **Utilisateur** : Administrator
- **Mot de passe** : admin

## Option B : Docker (Plus simple)

### 1. Installer Docker Desktop
```bash
# Télécharger Docker Desktop depuis docker.com
# Installer et redémarrer
```

### 2. Lancer ERPNext avec Docker
```bash
# Cloner le repository officiel
git clone https://github.com/frappe/frappe_docker.git
cd frappe_docker

# Lancer avec docker-compose
docker-compose up -d

# Attendre 5-10 minutes
# Accéder à http://localhost:8080
```

## Option C : Application portable

### Créer une application portable ERPNext
```bash
# Créer un dossier portable
mkdir ERPNext-Portable
cd ERPNext-Portable

# Télécharger les binaires
# (Cette option nécessite plus de configuration)
```

## Avantages installation locale :
- ✅ **100% GRATUIT**
- ✅ Fonctionne hors ligne
- ✅ Contrôle total
- ✅ Pas de limite de données
- ✅ Sauvegarde locale

## Inconvénients :
- ❌ Nécessite un PC dédié
- ❌ Configuration plus complexe
- ❌ Maintenance manuelle
