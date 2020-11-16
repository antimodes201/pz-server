FROM ubuntu:18.04
MAINTAINER antimodes201

# quash warnings
ARG DEBIAN_FRONTEND=noninteractive

ARG GAME_PORT=16262
ARG QUERY_PORT=16261

# Set some Variables
ENV GAME_PORT $GAME_PORT
ENV QUERY_PORT $QUERY_PORT
ENV PASSWORD "CHANGEME"
ENV ADDITIONAL_OPTS ""
ENV ADDITIONAL_ARGS ""
ENV TZ "America/New_York"

# dependencies
RUN dpkg --add-architecture i386 && \
        apt-get update && \
        apt-get install -y --no-install-recommends \
		libcurl3  \
		lib32gcc1 \
		wget \
		unzip \
		tzdata \
		ca-certificates && \
		rm -rf /var/lib/apt/lists/*

# create directories
RUN adduser \
    --disabled-login \
    --disabled-password \
    --shell /bin/bash \
    steamuser && \
    usermod -G tty steamuser \
        && mkdir -p /app \
		&& mkdir -p /scripts \
        && chown steamuser:steamuser /app \
		&& chown steamuser:steamuser /scripts 

# Install Steamcmd 
# depreciated.  Moved into start script
USER steamuser

ADD start.sh /scripts/start.sh

# Expose some port
EXPOSE $GAME_PORT/udp
EXPOSE $QUERY_PORT/tcp


# Make a volume
# contains configs and world saves
VOLUME /app

CMD ["/scripts/start.sh"]
