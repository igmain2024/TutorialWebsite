# Use an official Node.js runtime as the base image
FROM node:20 as dist

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json first (for caching dependencies)
COPY package*.json ./
# RUN npm install web-vitals

# Install dependencies
RUN npm install

# Copy the rest of the app files
COPY . .

# Build the React app
RUN npm run build

# Use a lightweight web server to serve the build
FROM nginx:alpine
EXPOSE 80
# Copy the build files to the nginx public directory
COPY --from=dist /app/dist /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]