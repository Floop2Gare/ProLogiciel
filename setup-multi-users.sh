#!/bin/bash

# ========================================
#    Configuration Multi-Utilisateurs ERPNext
# ========================================

echo "👥 Configuration Multi-Utilisateurs ERPNext"
echo "=========================================="
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

# Vérifier si ERPNext est installé
if [ ! -d "frappe-bench" ]; then
    print_error "ERPNext n'est pas installé. Veuillez d'abord installer ERPNext."
    exit 1
fi

cd frappe-bench

print_status "Configuration des utilisateurs ERPNext..."

# Créer les utilisateurs de base
print_status "Création des utilisateurs de base..."

# Utilisateur Vendeur
print_status "Création de l'utilisateur Vendeur..."
bench --site erpnext.localhost execute erpnext.setup.setup_users.create_user --args '{
    "email": "vendeur@entreprise.com",
    "first_name": "Vendeur",
    "last_name": "Principal",
    "password": "vendeur123",
    "role": "Vendeur"
}'

# Utilisateur Comptable
print_status "Création de l'utilisateur Comptable..."
bench --site erpnext.localhost execute erpnext.setup.setup_users.create_user --args '{
    "email": "comptable@entreprise.com",
    "first_name": "Comptable",
    "last_name": "Principal",
    "password": "comptable123",
    "role": "Comptable"
}'

# Utilisateur Manager
print_status "Création de l'utilisateur Manager..."
bench --site erpnext.localhost execute erpnext.setup.setup_users.create_user --args '{
    "email": "manager@entreprise.com",
    "first_name": "Manager",
    "last_name": "Principal",
    "password": "manager123",
    "role": "Manager"
}'

print_success "Utilisateurs créés avec succès !"
echo ""

# Afficher les informations de connexion
echo "=========================================="
echo "👥 UTILISATEURS ERPNext"
echo "=========================================="
echo ""
echo "🔑 INFORMATIONS DE CONNEXION :"
echo ""
echo "1. 👨‍💼 ADMINISTRATEUR :"
echo "   - Email : Administrator"
echo "   - Mot de passe : admin"
echo "   - Rôle : Administrateur complet"
echo ""
echo "2. 👨‍💼 VENDEUR :"
echo "   - Email : vendeur@entreprise.com"
echo "   - Mot de passe : vendeur123"
echo "   - Rôle : Ventes, Clients, Stocks"
echo ""
echo "3. 👨‍💼 COMPTABLE :"
echo "   - Email : comptable@entreprise.com"
echo "   - Mot de passe : comptable123"
echo "   - Rôle : Comptabilité, Factures, Paiements"
echo ""
echo "4. 👨‍💼 MANAGER :"
echo "   - Email : manager@entreprise.com"
echo "   - Mot de passe : manager123"
echo "   - Rôle : Vue d'ensemble, Rapports, Gestion"
echo ""

# Créer un script de gestion des utilisateurs
print_status "Création du script de gestion des utilisateurs..."

cat > manage-users.sh << 'EOF'
#!/bin/bash

# ========================================
#    Gestion des Utilisateurs ERPNext
# ========================================

echo "👥 Gestion des Utilisateurs ERPNext"
echo "=================================="
echo ""

# Fonction pour créer un utilisateur
create_user() {
    echo "Création d'un nouvel utilisateur..."
    read -p "Email : " email
    read -p "Prénom : " first_name
    read -p "Nom : " last_name
    read -p "Mot de passe : " password
    echo "Rôles disponibles : Vendeur, Comptable, Manager, Utilisateur"
    read -p "Rôle : " role
    
    bench --site erpnext.localhost execute erpnext.setup.setup_users.create_user --args "{
        \"email\": \"$email\",
        \"first_name\": \"$first_name\",
        \"last_name\": \"$last_name\",
        \"password\": \"$password\",
        \"role\": \"$role\"
    }"
    
    echo "✅ Utilisateur créé avec succès !"
}

# Fonction pour lister les utilisateurs
list_users() {
    echo "📋 Liste des utilisateurs :"
    bench --site erpnext.localhost execute frappe.desk.query_report.run --args '{
        "report_name": "User",
        "filters": {}
    }'
}

# Menu principal
while true; do
    echo ""
    echo "Que voulez-vous faire ?"
    echo "1. Créer un utilisateur"
    echo "2. Lister les utilisateurs"
    echo "3. Quitter"
    read -p "Choix : " choice
    
    case $choice in
        1) create_user ;;
        2) list_users ;;
        3) break ;;
        *) echo "Choix invalide" ;;
    esac
done
EOF

chmod +x manage-users.sh

print_success "Script de gestion créé : manage-users.sh"
echo ""

# Créer un guide de sécurité
print_status "Création du guide de sécurité..."

cat > security-guide.md << 'EOF'
# 🔐 Guide de Sécurité Multi-Utilisateurs

## 🛡️ Bonnes Pratiques de Sécurité

### 1. **Mots de passe forts**
- **Minimum 8 caractères**
- **Majuscules, minuscules, chiffres, symboles**
- **Changer régulièrement** (tous les 3 mois)

### 2. **Gestion des rôles**
- **Vendeur** : Accès ventes, clients, stocks
- **Comptable** : Accès comptabilité, factures, paiements
- **Manager** : Vue d'ensemble, rapports, gestion
- **Administrateur** : Contrôle total

### 3. **Sécurité réseau**
- **HTTPS obligatoire** (Railway fournit automatiquement)
- **Connexions sécurisées** uniquement
- **Pas de connexions publiques** non sécurisées

### 4. **Sauvegardes**
- **Sauvegardes automatiques** (Railway)
- **Sauvegardes manuelles** régulières
- **Test de restauration** périodique

### 5. **Audit et monitoring**
- **Logs d'accès** consultés régulièrement
- **Actions suspectes** signalées
- **Mises à jour** de sécurité appliquées

## 🚨 Alertes de Sécurité

### Signaux d'alarme :
- **Connexions multiples** depuis la même IP
- **Tentatives de connexion** échouées
- **Actions non autorisées** détectées
- **Modifications** de données sensibles

### Actions à prendre :
1. **Vérifier** les logs d'accès
2. **Changer** les mots de passe suspects
3. **Révoquer** les accès temporaires
4. **Signaler** les incidents

## 🔧 Configuration Sécurisée

### Paramètres ERPNext :
- **Session timeout** : 30 minutes
- **Tentatives de connexion** : 3 maximum
- **Verrouillage compte** : 15 minutes
- **Logs détaillés** : Activés

### Paramètres réseau :
- **Firewall** : Ports 80, 443 uniquement
- **VPN** : Recommandé pour accès distant
- **SSL/TLS** : Version 1.3 minimum

## 📱 Sécurité Mobile

### Application mobile :
- **Authentification** à deux facteurs
- **Chiffrement** des données locales
- **Verrouillage** automatique
- **Mise à jour** régulière

### Accès web mobile :
- **HTTPS** obligatoire
- **Sessions** courtes
- **Déconnexion** automatique
- **Pas de sauvegarde** des mots de passe

## 🆘 En cas de problème

### Incident de sécurité :
1. **Changer** tous les mots de passe
2. **Révoquer** les accès suspects
3. **Vérifier** les logs
4. **Contacter** le support

### Récupération de données :
1. **Utiliser** les sauvegardes
2. **Restaurer** depuis Railway
3. **Vérifier** l'intégrité
4. **Tester** les fonctionnalités

## 📞 Support

- **Documentation** : erpnext.com/docs
- **Communauté** : discuss.frappe.io
- **Support** : support@frappe.io
EOF

print_success "Guide de sécurité créé : security-guide.md"
echo ""

# Afficher les prochaines étapes
echo "=========================================="
echo "🎯 PROCHAINES ÉTAPES"
echo "=========================================="
echo ""
echo "1. 🚀 Démarrer ERPNext :"
echo "   bench start"
echo ""
echo "2. 🌐 Accéder à l'interface :"
echo "   http://localhost:8000"
echo ""
echo "3. 👥 Se connecter avec les utilisateurs créés"
echo ""
echo "4. 🔧 Gérer les utilisateurs :"
echo "   ./manage-users.sh"
echo ""
echo "5. 🔐 Consulter le guide de sécurité :"
echo "   security-guide.md"
echo ""

print_success "Configuration multi-utilisateurs terminée !"
