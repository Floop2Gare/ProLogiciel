#!/bin/bash

echo "🚀 Démarrage d'ERPNext optimisé pour Railway..."

# Variables d'environnement pour limiter la mémoire
export NODE_OPTIONS="--max-old-space-size=512"
export YARN_CACHE_FOLDER=/tmp/yarn-cache

# Initialisation de frappe-bench
echo "📦 Initialisation de frappe-bench..."
bench init --skip-redis-config --skip-supervisor-config --skip-assets frappe-bench --python "$(which python3)"

# Entrer dans le répertoire bench
cd frappe-bench

# Installer frappe
echo "📦 Installation de frappe..."
bench get-app frappe https://github.com/frappe/frappe.git --branch version-15
bench install-app frappe

# Installer erpnext
echo "📦 Installation d'ERPNext..."
bench get-app erpnext https://github.com/frappe/erpnext.git --branch version-15
bench install-app erpnext

# Création du site
echo "🌐 Création du site..."
bench new-site site1.local --admin-password admin --mariadb-root-password ""

# Configurer le site par défaut
bench use site1.local

# Installer ERPNext sur le site
echo "🔧 Installation d'ERPNext sur le site..."
bench --site site1.local install-app erpnext

# Construire les assets de manière optimisée
echo "🏗️ Construction des assets (optimisée)..."
bench build --skip-assets

# Démarrer le serveur
echo "✅ ERPNext prêt ! Démarrage du serveur..."
bench start --port 8000 --host 0.0.0.0
