FROM node:12.16.1-alpine3.11 as build
RUN apk upgrade && apk --no-cache add --upgrade && \
    apk add g++ alpine-sdk
WORKDIR /var/www
COPY . .
RUN yarn install

FROM build as dev
ENV NUXT_HOST=0.0.0.0 \
    NUXT_PORT=3000
EXPOSE 3000
CMD [ "yarn", "dev" ]

FROM build as prod
RUN yarn build
FROM node:12.16.1-alpine3.11
RUN apk upgrade && apk --no-cache add --upgrade
ENV NUXT_HOST=0.0.0.0 \
    NUXT_PORT=3000
WORKDIR /var/www
COPY --from=build /var/www/package.json ./package.json
COPY --from=build /var/www/yarn.lock ./yarn.lock
COPY --from=build /var/www/.nuxt ./.nuxt
RUN yarn install --production
EXPOSE 3000
CMD [ "yarn", "start" ]
