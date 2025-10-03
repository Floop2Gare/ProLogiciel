#!/bin/bash

# Script de démarrage ERPNext pour Railway
echo "🚀 Démarrage d'ERPNext sur Railway..."

# Variables d'environnement Railway
export DB_HOST=${DB_HOST:-localhost}
export DB_USER=${DB_USER:-erpnext}
export DB_PASSWORD=${DB_PASSWORD:-admin}
export DB_NAME=${DB_NAME:-erpnext}

# Aller dans le répertoire de travail
cd /home/frappe/erpnext-app

# Initialiser frappe-bench si pas encore fait
if [ ! -d "frappe-bench" ]; then
    echo "📦 Initialisation de frappe-bench..."
    bench init frappe-bench --frappe-branch version-15 --python python3.11
fi

cd frappe-bench

# Installer ERPNext si pas encore fait
if [ ! -d "apps/erpnext" ]; then
    echo "📦 Installation d'ERPNext..."
    bench get-app erpnext --branch version-15
fi

# Créer le site si pas encore fait
if [ ! -d "sites/erpnext.railway.app" ]; then
    echo "🌐 Création du site..."
    bench new-site erpnext.railway.app --admin-password admin --db-root-password admin
fi

# Installer ERPNext sur le site si pas encore fait
echo "🔧 Installation d'ERPNext sur le site..."
bench --site erpnext.railway.app install-app erpnext

# Démarrer le serveur
echo "✅ ERPNext prêt ! Démarrage du serveur..."
bench start --port 8000 --host 0.0.0.0
