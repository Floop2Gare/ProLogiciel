#!/bin/bash

# ========================================
#    Créateur d'installateur Mac ERPNext
# ========================================

echo "🍎 Création de l'installateur Mac ERPNext"
echo "=========================================="

# Créer la structure de l'application
mkdir -p ERPNext-Mac-Installer.app/Contents/MacOS
mkdir -p ERPNext-Mac-Installer.app/Contents/Resources

# Copier le script principal
cp ERPNext-Mac-Installer.app/Contents/MacOS/ERPNext-Installer ERPNext-Mac-Installer.app/Contents/MacOS/ERPNext-Installer.backup

# Rendre exécutable
chmod +x ERPNext-Mac-Installer.app/Contents/MacOS/ERPNext-Installer

echo "✅ Installateur Mac créé : ERPNext-Mac-Installer.app"
echo ""
echo "📁 Structure créée :"
echo "   - ERPNext-Mac-Installer.app/Contents/MacOS/ERPNext-Installer"
echo "   - ERPNext-Mac-Installer.app/Contents/Info.plist"
echo ""
echo "🚀 Pour utiliser :"
echo "   1. Transférer ERPNext-Mac-Installer.app sur un Mac"
echo "   2. Double-cliquer sur l'application"
echo "   3. Suivre les instructions à l'écran"
echo ""
echo "⚠️  Note : L'utilisateur devra autoriser l'installation des dépendances"
