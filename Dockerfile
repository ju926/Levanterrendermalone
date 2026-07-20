FROM quay.io/lyfe00011/md:beta

# Install procps package to fix the 'spawn ps ENOENT' error
RUN apt-get update && apt-get install -y procps && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/lyfe00011/levanter.git /root/LyFE/
WORKDIR /root/LyFE/

RUN yarn install

# Render requires a foreground runner instead of 'npm start' to manage the container lifecycle
CMD ["pm2-runtime", "index.js", "--name", "levanter"]
