FROM us-central1-docker.pkg.dev/database-toolbox/toolbox/toolbox:0.7.0

WORKDIR /app

COPY tools.yaml .

EXPOSE 5000

# Forza il bind su 0.0.0.0 invece di localhost
CMD ["./toolbox", "--tools-file", "tools.yaml", "--port", "5000", "--host", "0.0.0.0"]
