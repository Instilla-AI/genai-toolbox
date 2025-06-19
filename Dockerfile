# Utilizza l'immagine Docker ufficiale come base
FROM us-central1-docker.pkg.dev/database-toolbox/toolbox/toolbox:0.7.0

# Copia il tools.yaml dalla radice della tua repo GitHub all'interno del container
# Si presume che /app sia la working directory o un percorso accessibile per il toolbox
COPY tools.yaml /app/tools.yaml

# Se il toolbox ha un ENTRYPOINT/CMD che cerca un file specifico,
# dobbiamo assicurarci che lo trovi.
# L'immagine base del toolbox di solito esegue il binary `toolbox`.
# Dobbiamo passare l'argomento `--tools-file` al binary.
# Questo può essere fatto tramite la variabile d'ambiente `TOOLBOX_ARGS`.

# Non serve un CMD qui se l'immagine base ha già un ENTRYPOINT che esegue il toolbox
# Tuttavia, per essere espliciti e passare argomenti, potresti sovrascriverlo se necessario.
# Ma è meglio usare la variabile d'ambiente per gli argomenti di configurazione.
