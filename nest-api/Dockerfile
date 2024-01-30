###################
# BUILD FOR LOCAL DEVELOPMENT
###################

FROM node:18-alpine3.18 As development

WORKDIR /usr/src/app

COPY --chown=node:node package*.json ./

RUN npm ci

COPY --chown=node:node . .

RUN npm run generate

USER node

###################
# BUILD FOR PRODUCTION
###################

FROM node:18-alpine3.18 As build

WORKDIR /usr/src/app

COPY --chown=node:node package*.json ./

COPY --chown=node:node --from=development /usr/src/app/node_modules ./node_modules

COPY --chown=node:node . .

RUN npm run build

ENV NODE_ENV production

RUN npm ci && npm cache clean --force

# RUN npm run migrate

USER node

###################
# PRODUCTION
###################

FROM node:18-alpine3.18 As production

COPY --chown=node:node --from=build /usr/src/app/node_modules ./node_modules
COPY --chown=node:node --from=build /usr/src/app/package.json ./package.json
COPY --chown=node:node --from=build /usr/src/app/src/prisma/schema.prisma ./src/prisma/schema.prisma
COPY --chown=node:node --from=build /usr/src/app/dist ./dist

CMD [ "npm", "run", "start:prod" ]
