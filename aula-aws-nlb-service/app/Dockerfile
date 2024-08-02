# Use an official Node.js runtime as the base image
FROM node:20

# Create the directory for the application and set the ownership to the 'node' user
RUN mkdir -p /usr/src/app/node_modules && chown -R node:node /usr/src/app

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Switch to the 'node' user
USER node

# Install application dependencies
RUN npm ci --verbose

# Copy the rest of the application code
COPY --chown=node:node . .

# Expose the application port
EXPOSE 8081

# Specify the command to run your application
CMD ["npm", "start"]