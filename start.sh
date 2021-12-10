#!/bin/bash -ex
# Start script for Killing Floor 2 called from docker

# Move steamcmd install to startup
if [ ! -f /app/steamcmd/steamcmd.sh ]
then
	# no steamcmd
	printf "SteamCMD not found, installing\n"
	mkdir /app/steamcmd/
	cd /app/steamcmd/
	wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
	tar -xf steamcmd_linux.tar.gz
	rm steamcmd_linux.tar.gz
fi

# check for updates
build=${BRANCH}
if [ ${BRANCH} == "public" ]
then
	# GA
	/app/steamcmd/steamcmd.sh +force_install_dir /app +login anonymous +app_update 380870 +quit
else
	# Expermental 
	/app/steamcmd/steamcmd.sh +force_install_dir /app +login anonymous +app_update 380870 -beta ${BRANCH} +quit
fi

# symlink to app
if [ ! -d /app/configfiles ]
then
	mkdir /app/configfiles
fi
ln -s /app/configfiles /home/steamuser/Zomboid
	
# Launch Server
# Variables pulled from Docker environment
cd /app
./start-server.sh -servername ${SERVERNAME} -adminpassword ${PASSWORD}
