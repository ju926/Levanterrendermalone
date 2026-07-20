FROM quay.io/lyfe00011/md:beta

# Install procps for PM2 process management
RUN apt-get update && apt-get install -y procps && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/lyfe00011/levanter.git /root/LyFE/
WORKDIR /root/LyFE/

# Install application dependencies
RUN yarn install

# Start the application using PM2 as intended by Levanter
CMD ["pm2-runtime", "index.js", "--name", "levanter"]
