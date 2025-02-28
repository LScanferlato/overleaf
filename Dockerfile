# Usa un'immagine base con Node.js e MongoDB
FROM ubuntu:20.04

# Imposta le variabili d'ambiente per non interagire con il prompt durante l'installazione
ENV DEBIAN_FRONTEND=noninteractive

# Installa le dipendenze necessarie
RUN apt-get update && apt-get install -y \
    git \
    curl \
    nodejs \
    npm \
    texlive-full \
    texlive-xetex \
    texlive-latex-extra \
    texlive-fonts-extra \
    texlive-lang-all \
    ghostscript \
    poppler-utils \
    python3-pygments \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Installa MongoDB
RUN curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add - && \
    echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list && \
    apt-get update && apt-get install -y mongodb-org && \
    mkdir -p /data/db

# Clona il repository di Overleaf
RUN git clone https://github.com/overleaf/overleaf.git /overleaf

# Imposta la directory di lavoro
WORKDIR /overleaf

# Installa le dipendenze di Overleaf
RUN npm install

# Espone le porte necessarie
EXPOSE 3000

# Comando di avvio
CMD ["npm", "start"]
