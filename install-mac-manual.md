# 🍎 Installation manuelle ERPNext sur Mac

## 📋 Prérequis
- macOS 10.15 (Catalina) ou plus récent
- 8GB RAM minimum
- 20GB espace disque libre
- Connexion internet

## 🔧 Installation manuelle avec permissions

### Étape 1 : Installer Homebrew (gestionnaire de paquets)

1. **Ouvrir Terminal** (Applications > Utilitaires > Terminal)
2. **Copier et coller** cette commande :
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
3. **Entrer votre mot de passe** quand demandé
4. **Attendre** la fin de l'installation (5-10 minutes)

### Étape 2 : Installer Python 3.11

```bash
brew install python@3.11
```

**Vérification** :
```bash
python3 --version
# Doit afficher : Python 3.11.x
```

### Étape 3 : Installer Node.js

```bash
brew install node
```

**Vérification** :
```bash
node --version
npm --version
```

### Étape 4 : Installer Git

```bash
brew install git
```

### Étape 5 : Installer MariaDB (Base de données)

```bash
brew install mariadb
```

**Démarrer MariaDB** :
```bash
brew services start mariadb
```

**Configurer la base de données** :
```bash
mysql -u root
```

Dans MySQL, exécuter :
```sql
CREATE DATABASE erpnext;
CREATE USER 'erpnext'@'localhost' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON erpnext.* TO 'erpnext'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

### Étape 6 : Installer Redis (Cache)

```bash
brew install redis
brew services start redis
```

### Étape 7 : Installer frappe-bench

```bash
pip3 install frappe-bench
```

### Étape 8 : Créer le site ERPNext

```bash
# Créer le répertoire
mkdir ~/ERPNext
cd ~/ERPNext

# Initialiser frappe-bench
bench init frappe-bench --frappe-branch version-15 --python python3.11

cd frappe-bench

# Installer ERPNext
bench get-app erpnext --branch version-15

# Créer le site
bench new-site erpnext.localhost --admin-password admin --db-root-password admin --mariadb-root-password admin

# Installer ERPNext sur le site
bench --site erpnext.localhost install-app erpnext
```

### Étape 9 : Démarrer ERPNext

```bash
bench start
```

## 🎉 Accès à ERPNext

- **URL** : http://localhost:8000
- **Utilisateur** : Administrator
- **Mot de passe** : admin

## 🚀 Scripts de démarrage automatique

### Créer un script de démarrage :

```bash
# Créer le script
cat > ~/ERPNext/start-erpnext.sh << 'EOF'
#!/bin/bash
echo "🚀 Démarrage d'ERPNext..."

# Démarrer les services
brew services start mariadb
brew services start redis

# Attendre
sleep 3

# Démarrer ERPNext
cd ~/ERPNext/frappe-bench
bench start
EOF

# Rendre exécutable
chmod +x ~/ERPNext/start-erpnext.sh
```

### Créer un raccourci sur le Bureau :

```bash
# Créer le raccourci
cat > ~/Desktop/ERPNext.command << 'EOF'
#!/bin/bash
cd ~/ERPNext
./start-erpnext.sh
EOF

# Rendre exécutable
chmod +x ~/Desktop/ERPNext.command
```

## 🛑 Arrêt d'ERPNext

```bash
# Dans le terminal où ERPNext tourne
Ctrl + C

# Ou arrêter les services
brew services stop mariadb
brew services stop redis
```

## 🔧 Dépannage

### Problème de permissions :
```bash
sudo chown -R $(whoami) ~/ERPNext
```

### Problème de base de données :
```bash
brew services restart mariadb
```

### Problème de port occupé :
```bash
lsof -ti:8000 | xargs kill -9
```

## 📱 Application portable (Option avancée)

Pour créer une version portable qui fonctionne sans installation :

1. **Créer un package** avec tous les binaires
2. **Inclure** Python, Node.js, MariaDB
3. **Scripts** de démarrage automatique
4. **Interface** graphique simple

*Cette option nécessite plus de développement mais permet une installation "zero-config".*

## ✅ Vérification finale

Votre installation est réussie si :
- ✅ http://localhost:8000 s'ouvre
- ✅ Page de connexion ERPNext s'affiche
- ✅ Connexion avec Administrator/admin fonctionne
- ✅ Tableau de bord ERPNext s'affiche
