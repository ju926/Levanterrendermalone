# Use an official, lightweight, stable Node environment
FROM node:20-bookworm-slim

# Install system dependencies required for ffmpeg and process tracking
RUN apt-get update && apt-get install -y \
    git \
    ffmpeg \
    curl \
    procps \
    && rm -rf /var/lib/apt/lists/*

# Global install of yarn and pm2
RUN npm install -g yarn pm2

RUN git clone https://github.com/lyfe00011/levanter.git /root/LyFE/
WORKDIR /root/LyFE/

RUN yarn install --network-timeout 100000

# Increase Node's memory space and optimize thread execution to stop WebSocket drops
CMD ["pm2-runtime", "start", "index.js", "--node-args=--max-old-space-size=1024", "--name", "levanter"]
