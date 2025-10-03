#!/bin/bash

echo "🔧 Construction des assets ERPNext..."

# Aller dans le répertoire frappe-bench
cd /home/frappe/frappe-bench

# Mettre à jour browserslist
echo "🔄 Mise à jour de browserslist..."
npx update-browserslist-db@latest

# Installer les dépendances manquantes
echo "📦 Installation des dépendances manquantes..."
npm install -g less@^4.0.0 stylus@^0.60.0 vue-template-compiler@^2.6.0

# Construire les assets
echo "🏗️ Construction des assets..."
bench build --force

echo "✅ Assets construits avec succès !"
