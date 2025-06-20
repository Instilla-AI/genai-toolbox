FROM alpine:latest

RUN apk add --no-cache ca-certificates curl

WORKDIR /app

# Usa ADD invece di wget (gestisce meglio i permessi)
ADD https://storage.googleapis.com/genai-toolbox/v0.7.0/linux/amd64/toolbox ./toolbox

# Imposta permessi espliciti
RUN chmod +x ./toolbox

COPY tools.yaml .

# Railway preferisce questo formato
EXPOSE $PORT

# Comando diretto senza shell wrapper
EXEC ["./toolbox", "--tools-file", "tools.yaml", "--host", "0.0.0.0", "--port", "5000"]
