#Base Image
FROM node:18-alpine as build 
WORKDIR /app

#Copy package files and install dependencies 
COPY package*.json ./
RUN npm ci 

#Copy application code and build 
COPY . .
RUN npm run build


##############################
#Final Lightweight image for runtime 
##############################
FROM node:22-alpine
WORKDIR /app

#Copy built output + package files 
COPY package*.json ./
RUN npm ci --only=production

# Copy built output
#COPY --from=build /app/dist ./dist
# Copy built output + package files
COPY --from=build /app/package*.json ./
COPY --from=build /app/build ./build

# Copy any other files needed (like config, scripts)
COPY --from=build /app/src ./src
COPY . .
EXPOSE 9000

# Set environment variables (adjust DB URL, REDIS, etc. as needed)
ENV NODE_ENV=production

# Default startup command
CMD ["npm", "start"]
