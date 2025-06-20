# Dockerfile
FROM golang:1.21-alpine AS builder

WORKDIR /app

# Installa git e clona il repository
RUN apk add --no-cache git
RUN git clone https://github.com/googleapis/genai-toolbox.git .

# Scarica le dipendenze e compila
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o toolbox .

# Stage di produzione
FROM alpine:latest

RUN apk --no-cache add ca-certificates
WORKDIR /root/

# Copia l'eseguibile e il file di configurazione
COPY --from=builder /app/toolbox .
COPY tools.yaml .

# Esponi la porta
EXPOSE 5000

# Comando di avvio
CMD ["./toolbox", "--tools-file", "tools.yaml", "--host", "0.0.0.0", "--port", "5000"]
