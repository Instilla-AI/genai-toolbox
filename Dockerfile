FROM us-central1-docker.pkg.dev/database-toolbox/toolbox/toolbox:0.7.0

WORKDIR /usr/src/app
COPY tools.yaml .

# Crea un piccolo script di ingresso per gestire le credenziali
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

# Assicurati che questo sia l'ENTRYPOINT del tuo container
ENTRYPOINT ["./entrypoint.sh"]

# NON definire CMD se l'ENTRYPOINT chiama il toolbox direttamente.
# Altrimenti, se vuoi un CMD, fai in modo che chiami l'ENTRYPOINT
# e poi il toolbox. Per semplicità, ENTRYPOINT è meglio.
