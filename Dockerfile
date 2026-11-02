FROM node:20-bookworm-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    ffmpeg \
    curl \
    procps \
    && rm -rf /var/lib/apt/lists/*

# ⚡ FIX: Only install pm2 globally (since yarn already exists)
RUN npm install -g pm2

RUN git clone https://github.com/lyfe00011/levanter.git /root/LyFE/
WORKDIR /root/LyFE/

RUN yarn install --network-timeout 100000

# Foreground execution with optimized memory allocation to prevent WebSocket drop loops
CMD ["pm2-runtime", "start", "index.js", "--node-args=--max-old-space-size=1024", "--name", "levanter"]
