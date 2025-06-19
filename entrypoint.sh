#!/bin/bash

# Scrivi il contenuto della variabile d'ambiente GOOGLE_APPLICATION_CREDENTIALS_JSON
# in un file temporaneo all'interno del container.
# Il percorso deve essere scrivibile. /tmp/ è sicuro.
echo "$GOOGLE_APPLICATION_CREDENTIALS_JSON" > /tmp/gcloud_credentials.json

# Esporta la variabile GOOGLE_APPLICATION_CREDENTIALS per puntare al file appena creato.
# Questo farà sì che il SDK di Go trovi le credenziali come file.
export GOOGLE_APPLICATION_CREDENTIALS="/tmp/gcloud_credentials.json"

# Esegui il binary del genai-toolbox.
# Assicurati che il percorso del binary 'toolbox' sia corretto.
# L'immagine base del toolbox lo posiziona probabilmente in /toolbox
# o nella sua PATH. Se non funziona, prova il percorso assoluto /toolbox.
exec /toolbox --tools-file tools.yaml
