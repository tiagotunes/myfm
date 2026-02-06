FROM node:20

# Create app directory inside container
WORKDIR /app

# Install dependencies first (better caching)
COPY package*.json ./
RUN npm install

# Source code will be mounted via volume in docker-compose
EXPOSE 3000

# Start Nest in watch mode
CMD ["npm", "run", "start:dev"]