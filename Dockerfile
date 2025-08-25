FROM node:16-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install -g @medusajs/medusa-cli
RUN npm install
COPY . .
EXPOSE 9000
CMD ["medusa", "develop"]