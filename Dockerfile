FROM us-central1-docker.pkg.dev/database-toolbox/toolbox/toolbox:0.7.0

WORKDIR /usr/src/app # Puoi anche lasciare /usr/src/app per questo test

COPY tools.yaml .
COPY entrypoint.sh .

RUN ls -l / # LISTA IL CONTENUTO DELLA ROOT

RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
