#!/usr/bin/env bash
set -e

python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install git+https://github.com/googleapis/genai-toolbox.git
python -m genai_toolbox.cli --host 0.0.0.0 --port $PORT
