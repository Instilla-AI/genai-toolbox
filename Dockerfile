FROM us-central1-docker.pkg.dev/database-toolbox/toolbox/toolbox:0.7.0

WORKDIR /app

COPY tools.yaml .

EXPOSE 5000

# Debug semplice
CMD ["sh", "-c", "echo 'Starting toolbox...' && echo 'Tools file:' && cat tools.yaml && echo 'Starting process...' && ./toolbox --tools-file tools.yaml --port 5000"]
