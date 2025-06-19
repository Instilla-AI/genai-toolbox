FROM us-central1-docker.pkg.dev/database-toolbox/toolbox/toolbox:0.7.0

WORKDIR /usr/src/app
COPY tools.yaml .

# PRIMA copia il file entrypoint.sh nel container
COPY entrypoint.sh .

# POI rendilo eseguibile
RUN chmod +x entrypoint.sh

# Assicurati che questo sia l'ENTRYPOINT del tuo container
ENTRYPOINT ["./entrypoint.sh"]
