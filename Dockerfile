FROM alpine:latest

# Installa le dipendenze necessarie
RUN apk add --no-cache wget ca-certificates curl

# Crea directory di lavoro
WORKDIR /app

# Scarica il binario pre-compilato dalla release ufficiale
RUN wget -O toolbox https://storage.googleapis.com/genai-toolbox/v0.7.0/linux/amd64/toolbox && \
    chmod +x toolbox

# Copia il file di configurazione
COPY tools.yaml .

# Esponi la porta
EXPOSE 5000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:5000/health || exit 1

# Comando di avvio
CMD ["./toolbox", "--tools-file", "tools.yaml", "--host", "0.0.0.0", "--port", "5000"]
