FROM node:20.18.1-alpine3.20 as build

WORKDIR /usr/otel-practice

COPY . .

RUN npm i
RUN npm run build


FROM node:20.18.1-alpine3.20 as live

WORKDIR /usr/otel-practice

COPY --from=build /usr/otel-practice/package.json /usr/otel-practice/package.json
COPY --from=build /usr/otel-practice/package-lock.json /usr/otel-practice/package-lock.json
COPY --from=build /usr/otel-practice/dist /usr/otel-practice/dist
COPY --from=build /usr/otel-practice/node_modules /usr/otel-practice/node_modules
COPY --from=build /usr/otel-practice/node_modules /usr/otel-practice/node_modules

RUN chmod +x .

ENTRYPOINT [ "npm", "run", "start:prod" ]