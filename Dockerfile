FROM python:3.11-slim

WORKDIR /app
COPY . /app

RUN apt-get update && apt-get install -y git && \
    chmod +x setup.sh

EXPOSE 3000

CMD ["bash", "setup.sh"]
