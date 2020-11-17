FROM ubuntu:18.04
MAINTAINER antimodes201

# quash warnings
ARG DEBIAN_FRONTEND=noninteractive

ARG GAME_PORT=16262
ARG QUERY_PORT=16261
ARG STEAM1_PORT=8766
ARG STEAM2_PORT=8767

# Set some Variables
ENV GAME_PORT $GAME_PORT
ENV QUERY_PORT $QUERY_PORT
ENV STEAM1_PORT $STEAM1_PORT
ENV STEAM2_PORT $STEAM2_PORT
ENV PASSWORD "CHANGEME"
ENV SERVERNAME "default"
ENV ADDITIONAL_OPTS ""
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
EXPOSE $STEAM1_PORT/udp
EXPOSE $STEAM2_PORT/udp

# Make a volume
# contains configs and world saves
VOLUME /app

CMD ["/scripts/start.sh"]
