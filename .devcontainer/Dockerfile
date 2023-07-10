# Use the official Heroku image from the Docker Hub
FROM python:3.11-slim-bookworm

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV SFDX_CONTAINER_MODE=true
ENV SHELL=/bin/bash

# Update the system and install required tools
RUN apt-get update && apt-get install -y \
    curl \
    git \
    gnupg
#    openjdk-11-jdk-headless \
#    jq

# Install Node.js and verify the installation
# FIXME: Change back to using SHA
#RUN echo 'b298a73a9fc07badfa9e4a2e86ed48824fc9201327cdc43e3f3f58b273c535e7 ./nodejs.tar.gz' > node-file-lock.sha \
# && curl -s -o nodejs.tar.gz https://nodejs.org/dist/v18.15.0/node-v18.15.0-linux-x64.tar.gz \
# && shasum --check node-file-lock.sha \
# && mkdir /usr/local/lib/nodejs \
# && tar xf nodejs.tar.gz -C /usr/local/lib/nodejs/ --strip-components 1 \
# && rm nodejs.tar.gz node-file-lock.sha

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs

# Add Node.js to PATH
ENV PATH=/usr/local/lib/nodejs/bin:$PATH

# Install Salesforce CLI & Node Requirements
COPY .devcontainer/package.json /tmp/package.json
RUN cd /tmp && npm install && rm /tmp/package.json && cd /workspaces/d2x-codespaces
# Install Python and pip
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip

# Install CumulusCI & Python Requirements
COPY .devcontainer/requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt
RUN rm /tmp/requirements.txt

# Setup bash prompt
RUN git clone https://github.com/chris-marsh/pureline.git
COPY .devcontainer/pureline.conf /tmp/pureline.conf
RUN mv /tmp/pureline.conf ~/.pureline.conf
RUN echo 'if [ "$TERM" != "linux" ]; then\n    source ~/pureline/pureline ~/.pureline.conf\nfi' >> ~/.bashrc

# Cleanup
RUN apt-get autoremove --assume-yes \
 && apt-get clean --assume-yes \
 && rm -rf /var/lib/apt/lists/*

# Reset environment variables
ENV DEBIAN_FRONTEND=dialog

# Copy the startup script into the container
COPY .devcontainer/startup.sh /usr/local/bin/startup.sh

# Make the startup script executable
RUN chmod +x /usr/local/bin/startup.sh

# Run the startup script when the container starts
#CMD ["/usr/local/bin/startup.sh"]