# DOCKER-VERSION 0.3.4
FROM debian:9-slim


ARG DANCERPATH=/var/dancer 
RUN apt-get update -yq \
 && DEBIAN_FRONTEND=noninteractive \
    apt-get install -yq \
    perl \
    cpanminus \
    nmap \
    build-essential \
    libssl-dev \ 
    libexpat1-dev \
    libgdbm-dev \
 && cpanm -fv Dancer2 Nmap::Parser \ 
 && mkdir -p ${DANCERPATH} \
 && find /var/cache/apt/archives /var/lib/apt/lists -not -name lock -type f -delete \
 && apt-get clean -yq

COPY . ${DANCERPATH}

ENV DANCER_ENVIRONMENT production
EXPOSE 3000
WORKDIR ${DANCERPATH}
CMD perl dancer.pl
