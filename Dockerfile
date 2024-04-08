# From article: https://gist.github.com/aradalvand/04b2cad14b00e5ffe8ec96a3afbb34fb
# It assumes using adapter-node as the app adapter.

# === BUILD STAGE ===
# parent image
FROM node:18-alpine AS builder

# setting the working directory to /app, so that we don't have to repeat it for each subsequent COPY instruction
WORKDIR /app

# copy the package.json + package-lock.json files into the working directory
COPY package*.json .

# install all the dependencies.
# we're using npm ci as opposed to the regular npm install, since the former is more fit for productions environments
RUN npm ci

# copy the rest of the source files into the working directory
COPY . .

# SvelteKit generates the build directory, containing a standalone Node server that serves our application
RUN npm run build
# delete all the dev dependencies from the "node_modules" folder, since we no longer need any of them
RUN npm prune --production

# === FINAL STAGE ===
FROM node:18-alpine
WORKDIR /app

# here, we are copying the node_modules directory 
# (stripped of all the dev dependencies, since we did npm prune --production in the previous stage), 
# the package.json file, and of course the build directory, from the previous stage into the working directory.
COPY --from=builder /app/build build/
COPY --from=builder /app/node_modules node_modules/
COPY package.json .

# According to the adapter-node documentation, the default port that the application will run on is 3000.
# Assuming this, we are exposing the port 3000 via this instruction.
EXPOSE 3000

# Llet Node.js and other code that we're about to run know that this is a production environment
ENV NODE_ENV=production

# run the node build command — equivalent to node build/index.js — to start the server.
CMD [ "node", "build" ]
