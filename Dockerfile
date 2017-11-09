# https://docs.ghost.org/supported-node-versions/
# https://github.com/nodejs/LTS
FROM node:6-slim

ENV NODE_ENV production

ENV GHOST_INSTALL /var/lib/ghost

RUN apt-get update; \
    apt-get install -g knex-migrator

RUN mkdir -p "$GHOST_INSTALL"; \
    chown node:node "$GHOST_INSTALL"; 

COPY . "$GHOST_INSTALL";
WORKDIR "$GHOST_INSTALL"
RUN npm install; \
    knex-migrator init --mgpath node_modules/ghost

EXPOSE 8080
CMD ["node", "index.js"]