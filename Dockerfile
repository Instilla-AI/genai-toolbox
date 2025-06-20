FROM alpine:latest

RUN apk add --no-cache ca-certificates

WORKDIR /app

ADD https://storage.googleapis.com/genai-toolbox/v0.7.0/linux/amd64/toolbox toolbox
RUN chmod +x toolbox

COPY tools.yaml .

CMD ["./toolbox", "--tools-file", "tools.yaml", "--host", "0.0.0.0", "--port", "5000"]
