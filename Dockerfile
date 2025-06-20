FROM alpine:latest

# Installa dipendenze per debug
RUN apk add --no-cache wget ca-certificates curl bash

# Crea directory di lavoro
WORKDIR /app

# Scarica il binario con permessi corretti
RUN echo "Downloading toolbox binary..." && \
    wget -v https://storage.googleapis.com/genai-toolbox/v0.7.0/linux/amd64/toolbox -O toolbox && \
    echo "Download completed. Setting permissions..." && \
    chmod +x toolbox && \
    ls -la toolbox && \
    echo "Testing binary execution:" && \
    ./toolbox --help || echo "Help command failed, but binary might still work"

# Copia configurazione
COPY tools.yaml .

# Verifica il file di configurazione
RUN echo "Configuration file:" && \
    cat tools.yaml

EXPOSE 5000

# Script di startup corretto
RUN cat > start.sh << 'EOF'
#!/bin/bash
echo "Starting toolbox server..."
echo "Current directory: $(pwd)"
echo "Files in current directory:"
ls -la

echo "Environment variables:"
env | grep -E "(DATABASE|PORT)" || echo "No database env vars found"

echo "Checking toolbox permissions:"
ls -la toolbox

echo "Starting server..."
exec ./toolbox --tools-file tools.yaml --host 0.0.0.0 --port ${PORT:-5000}
EOF

# IMPORTANTE: Imposta i permessi per lo script
RUN chmod +x start.sh

CMD ["./start.sh"]
