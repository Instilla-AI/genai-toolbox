FROM us-central1-docker.pkg.dev/database-toolbox/toolbox/toolbox:0.7.0

WORKDIR /app

COPY tools.yaml .

EXPOSE 5000

# Script con logging esteso
RUN echo '#!/bin/sh' > start.sh && \
    echo 'echo "=== Starting GenAI Toolbox ==="' >> start.sh && \
    echo 'echo "Date: $(date)"' >> start.sh && \
    echo 'echo "Environment variables:"' >> start.sh && \
    echo 'env | grep PG' >> start.sh && \
    echo 'echo "Tools file content:"' >> start.sh && \
    echo 'cat tools.yaml' >> start.sh && \
    echo 'echo "=== Starting toolbox process ==="' >> start.sh && \
    echo './toolbox --tools-file tools.yaml --port 5000' >> start.sh && \
    chmod +x start.sh

CMD ["./start.sh"]
