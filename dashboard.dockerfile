# Initial contaier to build npm prod code
FROM node:lts-slim AS builder

# Set default directory as /app
WORKDIR /app

# Copy the into /app
COPY code /app

# RUN npm install to install all node dependencies
RUN npm install

# npm build to create a production ready code
RUN npm run-script build


# Final Container with only build code, nad no code base
FROM node:lts-slim

# Set default directory as /app
WORKDIR /app

RUN npm install -g serve

COPY --from=builder /app/build .

# Command to run on start of the container
CMD ["serve", "-p", "80", "-s", "."]