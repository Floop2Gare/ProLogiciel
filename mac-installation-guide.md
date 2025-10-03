# 🍎 Guide d'installation ERPNext sur Mac

## 🎯 3 Options d'installation

### **Option 1 : Installation automatique (RECOMMANDÉ)**
- **Fichier** : `install-mac.sh`
- **Avantages** : Tout automatique, demande les permissions
- **Temps** : 15-20 minutes

### **Option 2 : Application graphique**
- **Fichier** : `ERPNext-Mac-Installer.app`
- **Avantages** : Interface graphique, dialogues macOS
- **Temps** : 15-20 minutes

### **Option 3 : Installation manuelle**
- **Fichier** : `install-mac-manual.md`
- **Avantages** : Contrôle total, pas de scripts
- **Temps** : 30-45 minutes

---

## 🚀 Option 1 : Installation automatique

### Prérequis :
- macOS 10.15 ou plus récent
- Connexion internet
- 8GB RAM, 20GB espace disque

### Étapes :
1. **Télécharger** le fichier `install-mac.sh`
2. **Ouvrir Terminal** (Applications > Utilitaires > Terminal)
3. **Exécuter** :
```bash
chmod +x install-mac.sh
./install-mac.sh
```
4. **Entrer votre mot de passe** quand demandé
5. **Attendre** la fin de l'installation
6. **Double-cliquer** sur `ERPNext.command` sur le Bureau

### Ce qui sera installé automatiquement :
- ✅ Homebrew (gestionnaire de paquets)
- ✅ Python 3.11
- ✅ Node.js 18+
- ✅ Git
- ✅ MariaDB (base de données)
- ✅ Redis (cache)
- ✅ frappe-bench
- ✅ ERPNext

---

## 🖥️ Option 2 : Application graphique

### Prérequis :
- macOS 10.15 ou plus récent
- Connexion internet

### Étapes :
1. **Télécharger** `ERPNext-Mac-Installer.app`
2. **Double-cliquer** sur l'application
3. **Suivre** les dialogues à l'écran
4. **Autoriser** l'installation des dépendances
5. **Attendre** la fin de l'installation

### Avantages :
- ✅ Interface graphique native macOS
- ✅ Dialogues de confirmation
- ✅ Messages d'erreur clairs
- ✅ Raccourci automatique sur le Bureau

---

## 🔧 Option 3 : Installation manuelle

### Pour les utilisateurs avancés qui veulent contrôler chaque étape :

1. **Lire** le fichier `install-mac-manual.md`
2. **Suivre** chaque étape une par une
3. **Vérifier** chaque installation
4. **Configurer** manuellement la base de données

### Avantages :
- ✅ Contrôle total de l'installation
- ✅ Compréhension de chaque composant
- ✅ Dépannage plus facile
- ✅ Personnalisation possible

---

## 🔑 Connexion ERPNext

Une fois installé (quelle que soit l'option) :

- **URL** : http://localhost:8000
- **Utilisateur** : Administrator
- **Mot de passe** : admin

---

## 🚀 Démarrage rapide

### Après installation :
1. **Double-cliquer** sur `ERPNext.command` sur le Bureau
2. **Attendre** 2-3 minutes (premier démarrage)
3. **Ouvrir** http://localhost:8000
4. **Se connecter** avec Administrator/admin

---

## 🛑 Arrêt d'ERPNext

### Dans le terminal :
- **Ctrl + C** pour arrêter

### Ou utiliser le script :
```bash
cd ~/ERPNext
./stop-erpnext.sh
```

---

## 🔧 Dépannage

### Problème de permissions :
```bash
sudo chown -R $(whoami) ~/ERPNext
```

### Problème de base de données :
```bash
brew services restart mariadb
```

### Problème de port :
```bash
lsof -ti:8000 | xargs kill -9
```

### Réinstallation complète :
```bash
# Supprimer l'ancienne installation
rm -rf ~/ERPNext
rm ~/Desktop/ERPNext.command

# Relancer l'installation
./install-mac.sh
```

---

## 📱 Application portable (Option avancée)

Pour créer une version qui fonctionne sans installation :

### Créer un package complet :
1. **Inclure** tous les binaires (Python, Node.js, MariaDB)
2. **Scripts** de démarrage automatique
3. **Interface** graphique simple
4. **Installation** en un clic

*Cette option nécessite plus de développement mais permet une installation "zero-config".*

---

## ✅ Vérification de l'installation

Votre installation est réussie si :
- ✅ http://localhost:8000 s'ouvre
- ✅ Page de connexion ERPNext s'affiche
- ✅ Connexion avec Administrator/admin fonctionne
- ✅ Tableau de bord ERPNext s'affiche
- ✅ Raccourci `ERPNext.command` sur le Bureau

---

## 🎉 Félicitations !

ERPNext est maintenant installé et prêt à l'emploi sur votre Mac !
