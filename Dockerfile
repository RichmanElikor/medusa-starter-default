#Base Image
FROM node:18-alpine as build 
WORKDIR /app

#Copy package files and install dependencies 
COPY package*.json ./
RUN npm ci --only=production

#Copy application code and build 
COPY . .
RUN npm run build


##############################
#Final Lightweight image for runtime 
##############################
FROM node:18-alpine
WORKDIR /app

#Copy built output + package files 
COPY --from=build /app/package*.json ./
COPY --from=build /app/dist ./dist

# Install only production dependencies
RUN npm ci --only=production

# Expose the server port
EXPOSE 9000

# Default startup command
CMD ["node", "dist/index.js"]
