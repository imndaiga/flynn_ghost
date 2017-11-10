# https://docs.ghost.org/supported-node-versions/
# https://github.com/nodejs/LTS
FROM node:6-slim

ENV NODE_ENV production

ENV GHOST_INSTALL /var/lib/ghost

ADD package.json /tmp/package.json
RUN cd /tmp && \
    npm install -g knex-migrator && \
    npm install

RUN mkdir -p "$GHOST_INSTALL" && \
    cp -a /tmp/node_modules "$GHOST_INSTALL" && \
    chown node:node "$GHOST_INSTALL"

WORKDIR "$GHOST_INSTALL"
ADD . "$GHOST_INSTALL"

EXPOSE 8080
CMD ["sh","start_ghost.sh"]