#!/usr/bin/env bash
set -e

# Crea virtualenv
python3 -m venv .venv
source .venv/bin/activate

# Elimina vecchia cartella
rm -rf toolbox

# Clona repo genai-toolbox
git clone https://github.com/googleapis/genai-toolbox.git toolbox
cd toolbox

# Avvia MCP server testuale (es. text_tools.py)
python3 tools/text_tools.py --host 0.0.0.0 --port $PORT
