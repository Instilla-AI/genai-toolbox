FROM us-central1-docker.pkg.dev/database-toolbox/toolbox/toolbox:0.7.0

WORKDIR /usr/src/app
COPY tools.yaml .

COPY entrypoint.sh .

# AGGIUNGI QUESTA RIGA PER DEBUG:
RUN ls -l

RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
