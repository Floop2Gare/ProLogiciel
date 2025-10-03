# Dockerfile simplifié pour ERPNext sur Railway
FROM python:3.11-slim

# Variables d'environnement
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# Installer les dépendances système essentielles
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    build-essential \
    python3-dev \
    libffi-dev \
    libssl-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Installer Node.js 18
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# Installer Yarn
RUN npm install -g yarn

# Créer un utilisateur frappe
RUN useradd -m -s /bin/bash frappe

# Copier le script de démarrage AVANT de changer d'utilisateur
COPY start.sh /home/frappe/start.sh
RUN chmod +x /home/frappe/start.sh

# Changer d'utilisateur et configurer l'environnement
USER frappe
WORKDIR /home/frappe

# Installer frappe-bench
RUN pip3 install --user frappe-bench

# Ajouter au PATH
ENV PATH="/home/frappe/.local/bin:$PATH"

# Créer le répertoire de travail
RUN mkdir -p /home/frappe/erpnext-app
WORKDIR /home/frappe/erpnext-app

# Exposer le port
EXPOSE 8000

# Démarrer avec le script
CMD ["/home/frappe/start.sh"]
