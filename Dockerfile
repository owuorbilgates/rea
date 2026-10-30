FROM node:24.22.1-bookworm-slim

RUN apt-get update \
    && apt-get install --no-install-recommends -y ca-certificates git procps python3 \
    && rm -rf /var/lib/apt/lists/* \
    && npm install --global npm@11.16.0

WORKDIR /opt/rea

COPY . .

ENV HUSKY=0

RUN npm ci \
    && npm run build:cached

RUN apt-get update \
    && apt-get install --no-install-recommends -y chromium \
    && rm -rf /var/lib/apt/lists/*

USER node

ENTRYPOINT ["node", "scripts/rea.mjs"]
CMD ["mcp"]
