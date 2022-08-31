# ----- build image -----

FROM node:16.15.1-alpine AS build-env

WORKDIR /app

COPY . /app
RUN npm ci && npm build

RUN mkdir tmp && cp -r build package*.json tsconfig.json tmp

# ----- finale image -----

FROM node:16.15.1-alpine

WORKDIR /app
COPY --from=build-env /app/node_modules /app/node_modules
COPY --from=build-env /app/tmp /app
EXPOSE 8080

USER node
ENTRYPOINT [ "npm" ]
CMD [ "start:prod" ]