FROM node:18-alpine

WORKDIR /app
COPY . .

RUN npm install -g @medusajs/medusa-cli
RUN npm install

EXPOSE 9000

CMD ["medusa", "start"]
