FROM node:14-alpine AS ui-build
WORKDIR /usr/src/app
COPY my-app/ ./my-app/
RUN cd my-app && npm install && npm run build

FROM node:14-alpine AS server-build
WORKDIR /root/
COPY --from=ui-build /usr/src/app/my-app/dist ./my-app/dist
COPY api/package*.json ./api/
RUN cd api && npm install
COPY api/server.js ./api/

CMD ["node", "./api/server.js"]