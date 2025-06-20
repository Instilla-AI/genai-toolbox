FROM us-central1-docker.pkg.dev/database-toolbox/toolbox/toolbox:0.7.0

WORKDIR /app

COPY tools.yaml .

EXPOSE 5000

# IMPORTANTE: --address 0.0.0.0 è fondamentale per Railway
CMD ["./toolbox", "--tools-file", "tools.yaml", "--address", "0.0.0.0", "--port", "5000"]
