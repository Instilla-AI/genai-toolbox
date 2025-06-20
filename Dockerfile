FROM alpine:latest

RUN apk add --no-cache ca-certificates curl bash

WORKDIR /app

# Scarica il binario
RUN wget https://storage.googleapis.com/genai-toolbox/v0.7.0/linux/amd64/toolbox && \
    chmod 755 toolbox

# Crea script wrapper con permessi corretti
RUN echo '#!/bin/bash' > /usr/local/bin/start-toolbox && \
    echo 'cd /app' >> /usr/local/bin/start-toolbox && \
    echo 'exec ./toolbox "$@"' >> /usr/local/bin/start-toolbox && \
    chmod 755 /usr/local/bin/start-toolbox

COPY tools.yaml .

EXPOSE 5000

ENTRYPOINT ["/usr/local/bin/start-toolbox"]
CMD ["--tools-file", "tools.yaml", "--host", "0.0.0.0", "--port", "5000"]
