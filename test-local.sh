#!/bin/bash

echo "========================================"
echo "    Test ERPNext Local - Mac/Linux"
echo "========================================"
echo ""

echo "Vérification de Docker..."
if ! command -v docker &> /dev/null; then
    echo "ERREUR: Docker n'est pas installé"
    echo "Veuillez installer Docker Desktop"
    exit 1
fi

echo "Docker détecté ! Démarrage du test..."
echo ""

echo "Construction de l'image Docker..."
docker build -t erpnext-test .

echo ""
echo "Démarrage d'ERPNext..."
echo "URL: http://localhost:8000"
echo "Utilisateur: Administrator"
echo "Mot de passe: admin"
echo ""

docker run -p 8000:8000 erpnext-test

echo ""
echo "Test terminé !"
