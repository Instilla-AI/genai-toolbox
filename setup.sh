#!/usr/bin/env bash
set -e

# Crea ambiente virtuale
python3 -m venv .venv
source .venv/bin/activate

# Clona toolbox (localmente)
git clone https://github.com/googleapis/genai-toolbox.git toolbox
cd toolbox

# Avvia MCP server
python3 -m genai_toolbox.cli --host 0.0.0.0 --port $PORT
