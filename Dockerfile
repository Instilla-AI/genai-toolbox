FROM alpine:latest

# Installa dipendenze per debug
RUN apk add --no-cache wget ca-certificates curl bash

# Crea directory di lavoro
WORKDIR /app

# Scarica il binario con controlli
RUN echo "Downloading toolbox binary..." && \
    wget -v https://storage.googleapis.com/genai-toolbox/v0.7.0/linux/amd64/toolbox -O toolbox && \
    echo "Download completed. File info:" && \
    ls -la toolbox && \
    file toolbox && \
    chmod +x toolbox && \
    echo "Made executable. Testing binary:" && \
    ./toolbox --help || echo "Binary test failed but continuing..."

# Copia configurazione
COPY tools.yaml .

# Verifica il file di configurazione
RUN echo "Configuration file:" && \
    cat tools.yaml && \
    echo "File permissions:" && \
    ls -la

EXPOSE 5000

# Script di startup con debug
RUN echo '#!/bin/bash' > start.sh && \
    echo 'echo "Starting toolbox server..."' >> start.sh && \
    echo 'echo "Current directory: $(pwd)"' >> start.sh && \
    echo 'echo "Files in current directory:"' >> start.sh && \
    echo 'ls -la' >> start.sh && \
    echo 'echo "Environment variables:"' >> start.sh && \
    echo 'env | grep -E "(DATABASE|PORT)" || echo "No database env vars found"' >> start.sh && \
    echo 'echo "Testing toolbox version:"' >> start.sh && \
    echo './toolbox --version || echo "Version check failed"' >> start.sh && \
    echo 'echo "Starting server with debug..."' >> start.sh && \
    echo 'exec ./toolbox --tools-file tools.yaml --host 0.0.0.0 --port ${PORT:-5000} --log-level debug' >> start.sh && \
    chmod +x start.sh

CMD ["./start.sh"]
