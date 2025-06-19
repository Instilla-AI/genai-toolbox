# Utilizza l'immagine Docker ufficiale come base
FROM us-central1-docker.pkg.dev/database-toolbox/toolbox/toolbox:0.7.0

# Se in futuro avessi bisogno di aggiungere file di configurazione specifici
# o altre dipendenze, potresti farlo qui.
# Ad esempio, per copiare un tools.yaml dalla tua repo GitHub all'interno del container:
# COPY tools.yaml /app/config/tools.yaml
