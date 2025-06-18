FROM python:3.11-slim

WORKDIR /app
COPY . /app

# Rimuovi completamente il comando pip install (non necessario)
# oppure tieni solo per sicurezza pip upgrade
RUN pip install --upgrade pip

EXPOSE 3000

CMD ["python", "server.py"]
