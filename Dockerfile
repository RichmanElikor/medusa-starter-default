FROM node:16-alpine
WORKDIR /app
COPY package*.json ./
#RUN npm install 
RUN npm install
COPY . .
EXPOSE 9000
CMD ["npx", "medusa", "develop"]