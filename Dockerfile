# Usa un'immagine base con Go
FROM golang:1.21-alpine AS builder

# Installa dipendenze necessarie
RUN apk add --no-cache git

# Installa GenAI Toolbox
RUN go install github.com/googleapis/genai-toolbox@v0.7.0

# Immagine finale
FROM alpine:latest

# Installa certificati SSL
RUN apk --no-cache add ca-certificates

# Copia il binario dalla fase di build
COPY --from=builder /go/bin/genai-toolbox /usr/local/bin/toolbox

# Crea directory per la configurazione
WORKDIR /app

# Copia il file di configurazione
COPY tools.yaml .

# Esponi la porta
EXPOSE 5000

# Comando di avvio
CMD ["toolbox", "--tools-file", "tools.yaml"]
