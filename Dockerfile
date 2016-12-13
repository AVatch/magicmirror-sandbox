FROM node:argon
MAINTAINER Adrian Vatchinsky <akv36@cornell.edu>

# Setup labels
LABEL version="0.0.1"
LABEL vendor="foundry"

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    libopencv-dev \
    python-opencv \
 && rm -rf /var/lib/apt/lists/*

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json /usr/src/app/
RUN npm install

# Bundle app source
COPY . /usr/src/app

# Expose the port - this is defined in config.js
EXPOSE 8080

# Start the mirror
CMD [ "node", "serveronly" ]
# CMD ["npm", "start"]