FROM alpine:latest

# Installa dipendenze necessarie
RUN apk add --no-cache ca-certificates curl bash

WORKDIR /app

# Scarica il binario e imposta permessi corretti
RUN wget https://storage.googleapis.com/genai-toolbox/v0.7.0/linux/amd64/toolbox -O toolbox && \
    chmod 755 toolbox && \
    chown root:root toolbox

# Copia il file di configurazione
COPY tools.yaml .

# Assicurati che il file di configurazione abbia i permessi corretti
RUN chmod 644 tools.yaml

EXPOSE 5000

# Usa ENTRYPOINT invece di CMD per Railway
ENTRYPOINT ["./toolbox", "--tools-file", "tools.yaml", "--host", "0.0.0.0", "--port", "5000"]
