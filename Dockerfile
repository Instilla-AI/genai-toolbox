FROM alpine:latest

# Installa dipendenze
RUN apk add --no-cache curl ca-certificates

# Scarica il binario precompilato
RUN curl -O https://storage.googleapis.com/genai-toolbox/v0.7.0/linux/amd64/toolbox && \
    chmod +x toolbox && \
    mv toolbox /usr/local/bin/

# Directory di lavoro
WORKDIR /app

# Copia configurazione
COPY tools.yaml .

# Esponi porta
EXPOSE 5000

# Avvia
CMD ["toolbox", "--tools-file", "tools.yaml"]
