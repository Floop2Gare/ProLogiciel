# Dockerfile fonctionnel pour ERPNext sur Railway
FROM python:3.11-slim

# Variables d'environnement
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# Installer toutes les dépendances nécessaires
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    build-essential \
    python3-dev \
    libffi-dev \
    libssl-dev \
    pkg-config \
    redis-server \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Installer Node.js 18
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# Installer Yarn
RUN npm install -g yarn

# Installer les dépendances Node.js manquantes
RUN npm install -g less@^4.0.0 stylus@^0.60.0 vue-template-compiler@^2.6.0

# Créer utilisateur frappe
RUN useradd -m -s /bin/bash frappe

# Copier le script de démarrage
COPY start-working.sh /start.sh
RUN chmod +x /start.sh

# Changer d'utilisateur
USER frappe
WORKDIR /home/frappe

# Installer frappe-bench
RUN pip3 install --user frappe-bench

# Ajouter au PATH
ENV PATH="/home/frappe/.local/bin:$PATH"

# Exposer le port
EXPOSE 8000

# Démarrer
CMD ["/start.sh"]
