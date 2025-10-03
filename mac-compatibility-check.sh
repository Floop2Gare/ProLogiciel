#!/bin/bash

# ========================================
#    Vérification de compatibilité Mac
# ========================================

echo "🍎 Vérification de compatibilité Mac pour ERPNext"
echo "================================================"
echo ""

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Fonctions
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[⚠]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

# Vérifier le système d'exploitation
print_status "Vérification du système d'exploitation..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    print_success "macOS détecté"
    
    # Version de macOS
    MACOS_VERSION=$(sw_vers -productVersion)
    print_status "Version macOS : $MACOS_VERSION"
    
    # Vérifier si la version est compatible
    if [[ $(echo "$MACOS_VERSION" | cut -d. -f1) -ge 10 ]] && [[ $(echo "$MACOS_VERSION" | cut -d. -f2) -ge 15 ]]; then
        print_success "Version macOS compatible (10.15+)"
    else
        print_error "Version macOS trop ancienne (minimum 10.15 requis)"
        exit 1
    fi
else
    print_error "Ce script est conçu pour macOS uniquement"
    exit 1
fi

# Vérifier l'architecture
print_status "Vérification de l'architecture..."
ARCH=$(uname -m)
if [[ "$ARCH" == "arm64" ]]; then
    print_success "Apple Silicon (M1/M2) détecté"
    HOMEBREW_PATH="/opt/homebrew"
elif [[ "$ARCH" == "x86_64" ]]; then
    print_success "Intel x86_64 détecté"
    HOMEBREW_PATH="/usr/local"
else
    print_warning "Architecture non standard : $ARCH"
fi

# Vérifier l'espace disque
print_status "Vérification de l'espace disque..."
AVAILABLE_SPACE=$(df -h . | awk 'NR==2 {print $4}' | sed 's/G//')
if [[ $AVAILABLE_SPACE -gt 20 ]]; then
    print_success "Espace disque suffisant : ${AVAILABLE_SPACE}GB disponible"
else
    print_warning "Espace disque limité : ${AVAILABLE_SPACE}GB (recommandé : 20GB+)"
fi

# Vérifier la RAM
print_status "Vérification de la RAM..."
TOTAL_RAM=$(sysctl -n hw.memsize | awk '{print int($1/1024/1024/1024)}')
if [[ $TOTAL_RAM -ge 8 ]]; then
    print_success "RAM suffisante : ${TOTAL_RAM}GB"
else
    print_warning "RAM limitée : ${TOTAL_RAM}GB (recommandé : 8GB+)"
fi

# Vérifier les permissions
print_status "Vérification des permissions..."
if [[ -w "$HOME" ]]; then
    print_success "Permissions d'écriture dans le répertoire utilisateur"
else
    print_error "Pas de permissions d'écriture dans le répertoire utilisateur"
    exit 1
fi

# Vérifier la connexion internet
print_status "Vérification de la connexion internet..."
if ping -c 1 google.com &> /dev/null; then
    print_success "Connexion internet disponible"
else
    print_error "Pas de connexion internet (requis pour l'installation)"
    exit 1
fi

# Vérifier les outils existants
print_status "Vérification des outils existants..."

# Homebrew
if command -v brew &> /dev/null; then
    print_success "Homebrew déjà installé"
    BREW_VERSION=$(brew --version | head -n1)
    print_status "Version : $BREW_VERSION"
else
    print_warning "Homebrew non installé (sera installé automatiquement)"
fi

# Python
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version | cut -d' ' -f2)
    print_success "Python déjà installé : $PYTHON_VERSION"
    
    # Vérifier la version
    if [[ $(echo "$PYTHON_VERSION" | cut -d. -f2) -ge 11 ]]; then
        print_success "Version Python compatible (3.11+)"
    else
        print_warning "Version Python ancienne : $PYTHON_VERSION (recommandé : 3.11+)"
    fi
else
    print_warning "Python non installé (sera installé automatiquement)"
fi

# Node.js
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version | cut -d'v' -f2)
    print_success "Node.js déjà installé : $NODE_VERSION"
    
    # Vérifier la version
    if [[ $(echo "$NODE_VERSION" | cut -d. -f1) -ge 18 ]]; then
        print_success "Version Node.js compatible (18+)"
    else
        print_warning "Version Node.js ancienne : $NODE_VERSION (recommandé : 18+)"
    fi
else
    print_warning "Node.js non installé (sera installé automatiquement)"
fi

# Git
if command -v git &> /dev/null; then
    print_success "Git déjà installé"
else
    print_warning "Git non installé (sera installé automatiquement)"
fi

# MariaDB
if command -v mysql &> /dev/null; then
    print_success "MariaDB/MySQL déjà installé"
else
    print_warning "MariaDB non installé (sera installé automatiquement)"
fi

# Redis
if command -v redis-server &> /dev/null; then
    print_success "Redis déjà installé"
else
    print_warning "Redis non installé (sera installé automatiquement)"
fi

echo ""
echo "================================================"
echo "📋 RÉSUMÉ DE COMPATIBILITÉ"
echo "================================================"

# Calculer le score de compatibilité
COMPATIBILITY_SCORE=0
TOTAL_CHECKS=8

# Système
if [[ $(echo "$MACOS_VERSION" | cut -d. -f1) -ge 10 ]] && [[ $(echo "$MACOS_VERSION" | cut -d. -f2) -ge 15 ]]; then
    ((COMPATIBILITY_SCORE++))
fi

# Espace disque
if [[ $AVAILABLE_SPACE -gt 20 ]]; then
    ((COMPATIBILITY_SCORE++))
fi

# RAM
if [[ $TOTAL_RAM -ge 8 ]]; then
    ((COMPATIBILITY_SCORE++))
fi

# Permissions
if [[ -w "$HOME" ]]; then
    ((COMPATIBILITY_SCORE++))
fi

# Internet
if ping -c 1 google.com &> /dev/null; then
    ((COMPATIBILITY_SCORE++))
fi

# Architecture
if [[ "$ARCH" == "arm64" ]] || [[ "$ARCH" == "x86_64" ]]; then
    ((COMPATIBILITY_SCORE++))
fi

# Outils existants
if command -v brew &> /dev/null; then
    ((COMPATIBILITY_SCORE++))
fi

# Python
if command -v python3 &> /dev/null && [[ $(python3 --version | cut -d' ' -f2 | cut -d. -f2) -ge 11 ]]; then
    ((COMPATIBILITY_SCORE++))
fi

# Afficher le score
PERCENTAGE=$((COMPATIBILITY_SCORE * 100 / TOTAL_CHECKS))

if [[ $PERCENTAGE -ge 80 ]]; then
    print_success "Compatibilité excellente : $PERCENTAGE% ($COMPATIBILITY_SCORE/$TOTAL_CHECKS)"
    echo ""
    print_success "✅ Votre Mac est parfaitement compatible avec ERPNext !"
    echo ""
    echo "🚀 Vous pouvez procéder à l'installation :"
    echo "   - Option 1 : ./install-mac.sh (automatique)"
    echo "   - Option 2 : ERPNext-Mac-Installer.app (graphique)"
    echo "   - Option 3 : install-mac-manual.md (manuelle)"
elif [[ $PERCENTAGE -ge 60 ]]; then
    print_warning "Compatibilité bonne : $PERCENTAGE% ($COMPATIBILITY_SCORE/$TOTAL_CHECKS)"
    echo ""
    print_warning "⚠️  Votre Mac est compatible mais avec quelques limitations"
    echo ""
    echo "🔧 Recommandations :"
    if [[ $AVAILABLE_SPACE -le 20 ]]; then
        echo "   - Libérer de l'espace disque (recommandé : 20GB+)"
    fi
    if [[ $TOTAL_RAM -lt 8 ]]; then
        echo "   - Fermer d'autres applications pour libérer de la RAM"
    fi
    echo ""
    echo "🚀 Vous pouvez procéder à l'installation avec des performances réduites"
else
    print_error "Compatibilité limitée : $PERCENTAGE% ($COMPATIBILITY_SCORE/$TOTAL_CHECKS)"
    echo ""
    print_error "❌ Votre Mac n'est pas compatible avec ERPNext"
    echo ""
    echo "🔧 Actions requises :"
    if [[ $(echo "$MACOS_VERSION" | cut -d. -f1) -lt 10 ]] || [[ $(echo "$MACOS_VERSION" | cut -d. -f2) -lt 15 ]]; then
        echo "   - Mettre à jour macOS vers 10.15 ou plus récent"
    fi
    if [[ $AVAILABLE_SPACE -le 20 ]]; then
        echo "   - Libérer de l'espace disque (minimum 20GB)"
    fi
    if [[ $TOTAL_RAM -lt 8 ]]; then
        echo "   - Ajouter de la RAM (minimum 8GB)"
    fi
    if ! ping -c 1 google.com &> /dev/null; then
        echo "   - Vérifier la connexion internet"
    fi
fi

echo ""
echo "================================================"
echo "📞 Support"
echo "================================================"
echo "Si vous rencontrez des problèmes :"
echo "1. Vérifier les logs d'installation"
echo "2. Redémarrer votre Mac"
echo "3. Vérifier les permissions dans Préférences Système > Sécurité"
echo "4. Consulter le guide de dépannage dans mac-installation-guide.md"
