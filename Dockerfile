FROM golang:1.21-alpine AS builder

WORKDIR /app

# Clone del repository
RUN apk add --no-cache git
RUN git clone https://github.com/googleapis/genai-toolbox.git .

# Build dell'applicazione
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o toolbox .

# Stage finale
FROM alpine:latest

RUN apk --no-cache add ca-certificates
WORKDIR /root/

COPY --from=builder /app/toolbox .
COPY --from=builder /app/examples/tools.yaml ./tools.yaml

EXPOSE 5000

CMD ["./toolbox", "--tools-file", "tools.yaml", "--host", "0.0.0.0", "--port", "5000"]
