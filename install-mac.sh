#!/bin/bash

# ========================================
#    ERPNext - Installation Mac
# ========================================

echo "🍎 ERPNext pour Mac - Installation automatique"
echo "=============================================="
echo ""

# Couleurs pour les messages
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Fonction pour afficher les messages colorés
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Vérifier si on est sur Mac
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "Ce script est conçu pour macOS uniquement"
    exit 1
fi

print_status "Démarrage de l'installation ERPNext pour Mac..."

# Demander les permissions administrateur
print_warning "Cette installation nécessite des permissions administrateur"
echo "Veuillez entrer votre mot de passe macOS quand demandé :"
echo ""

# Vérifier si Homebrew est installé
if ! command -v brew &> /dev/null; then
    print_status "Installation de Homebrew (gestionnaire de paquets Mac)..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Ajouter Homebrew au PATH pour les Macs avec Apple Silicon
    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    
    print_success "Homebrew installé avec succès"
else
    print_success "Homebrew déjà installé"
fi

# Installer les dépendances minimales
print_status "Installation des dépendances..."

# Python 3.11
print_status "Installation de Python 3.11..."
brew install python@3.11

# Node.js
print_status "Installation de Node.js..."
brew install node

# Git
print_status "Installation de Git..."
brew install git

# MariaDB (base de données)
print_status "Installation de MariaDB..."
brew install mariadb

# Redis (cache)
print_status "Installation de Redis..."
brew install redis

# Démarrer les services
print_status "Démarrage des services de base de données..."

# Démarrer MariaDB
brew services start mariadb
sleep 3

# Démarrer Redis
brew services start redis
sleep 2

# Configurer MariaDB
print_status "Configuration de la base de données..."
mysql -u root -e "CREATE DATABASE IF NOT EXISTS erpnext;"
mysql -u root -e "CREATE USER IF NOT EXISTS 'erpnext'@'localhost' IDENTIFIED BY 'admin';"
mysql -u root -e "GRANT ALL PRIVILEGES ON erpnext.* TO 'erpnext'@'localhost';"
mysql -u root -e "FLUSH PRIVILEGES;"

print_success "Base de données configurée"

# Installer frappe-bench
print_status "Installation de frappe-bench..."
pip3 install frappe-bench

# Créer le répertoire de travail
WORK_DIR="$HOME/ERPNext"
mkdir -p "$WORK_DIR"
cd "$WORK_DIR"

# Initialiser frappe-bench
print_status "Initialisation de frappe-bench..."
bench init frappe-bench --frappe-branch version-15 --python python3.11

cd frappe-bench

# Installer ERPNext
print_status "Installation d'ERPNext..."
bench get-app erpnext --branch version-15

# Créer un nouveau site
print_status "Création du site ERPNext..."
bench new-site erpnext.localhost --admin-password admin --db-root-password admin --mariadb-root-password admin

# Installer ERPNext sur le site
print_status "Installation d'ERPNext sur le site..."
bench --site erpnext.localhost install-app erpnext

# Créer les scripts de démarrage
print_status "Création des scripts de démarrage..."

# Script de démarrage
cat > start-erpnext.sh << 'EOF'
#!/bin/bash
echo "🚀 Démarrage d'ERPNext..."

# Démarrer les services
brew services start mariadb
brew services start redis

# Attendre que les services démarrent
sleep 3

# Aller dans le répertoire ERPNext
cd ~/ERPNext/frappe-bench

# Démarrer ERPNext
bench start

echo "✅ ERPNext démarré !"
echo "🌐 Ouvrez votre navigateur sur : http://localhost:8000"
echo "👤 Utilisateur : Administrator"
echo "🔑 Mot de passe : admin"
EOF

# Script d'arrêt
cat > stop-erpnext.sh << 'EOF'
#!/bin/bash
echo "🛑 Arrêt d'ERPNext..."

# Arrêter les services
brew services stop mariadb
brew services stop redis

echo "✅ ERPNext arrêté !"
EOF

# Rendre les scripts exécutables
chmod +x start-erpnext.sh
chmod +x stop-erpnext.sh

# Créer un raccourci sur le Bureau
print_status "Création d'un raccourci sur le Bureau..."
cat > ~/Desktop/ERPNext.command << 'EOF'
#!/bin/bash
cd ~/ERPNext
./start-erpnext.sh
EOF
chmod +x ~/Desktop/ERPNext.command

print_success "Installation terminée avec succès !"
echo ""
echo "🎉 ERPNext est maintenant installé sur votre Mac !"
echo ""
echo "📁 Fichiers créés :"
echo "   - ~/ERPNext/ (dossier principal)"
echo "   - ~/Desktop/ERPNext.command (raccourci)"
echo ""
echo "🚀 Pour démarrer ERPNext :"
echo "   1. Double-cliquez sur 'ERPNext.command' sur le Bureau"
echo "   2. Ou exécutez : cd ~/ERPNext && ./start-erpnext.sh"
echo ""
echo "🌐 Accès :"
echo "   - URL : http://localhost:8000"
echo "   - Utilisateur : Administrator"
echo "   - Mot de passe : admin"
echo ""
echo "🛑 Pour arrêter :"
echo "   - Ctrl+C dans le terminal"
echo "   - Ou exécutez : cd ~/ERPNext && ./stop-erpnext.sh"
echo ""

# Proposer de démarrer maintenant
read -p "Voulez-vous démarrer ERPNext maintenant ? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_status "Démarrage d'ERPNext..."
    ./start-erpnext.sh
fi
