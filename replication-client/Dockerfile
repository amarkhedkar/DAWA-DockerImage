FROM node:12.21-stretch

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update \
    && apt-get -qq install --no-install-recommends -y apt-utils postgresql-client-9.6 < /dev/null > /dev/null \
    && apt-get -qq clean \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g @dawadk/replication-client@1.3.19

RUN useradd --system dawa-replicator

WORKDIR /app

RUN mkdir config

COPY config/* config/

RUN chown -R dawa-replicator /app/config \
    && chmod -R 700 /app/config

COPY wrapper.sh .
RUN chown dawa-replicator wrapper.sh \
    && chmod 700 wrapper.sh

USER dawa-replicator

ENTRYPOINT ["bash", "./wrapper.sh"]

