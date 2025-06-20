FROM alpine:latest

# Installa dipendenze
RUN apk add --no-cache ca-certificates curl bash

# Crea un utente non-root
RUN addgroup -g 1000 appuser && \
    adduser -D -s /bin/sh -u 1000 -G appuser appuser

WORKDIR /app

# Scarica il binario come root
RUN wget https://storage.googleapis.com/genai-toolbox/v0.7.0/linux/amd64/toolbox -O toolbox && \
    chmod 755 toolbox

# Copia configurazione
COPY tools.yaml .

# Cambia ownership a appuser
RUN chown -R appuser:appuser /app

# Cambia all'utente non-root
USER appuser

EXPOSE 5000

CMD ["./toolbox", "--tools-file", "tools.yaml", "--host", "0.0.0.0", "--port", "5000"]
