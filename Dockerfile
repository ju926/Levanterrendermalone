FROM quay.io/lyfe00011/md:beta

# Install procps package to fix the 'spawn ps ENOENT' error
RUN apt-get update && apt-get install -y procps && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com /root/LyFE/
WORKDIR /root/LyFE/

RUN yarn install

# Render requires a non-daemon execution to track container status
CMD ["pm2-runtime", "index.js", "--name", "levanter"]
