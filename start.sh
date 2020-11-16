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
/app/steamcmd/steamcmd.sh +login anonymous +force_install_dir /app +app_update 380870 +quit

# symlink to app
if [ ! -f configfiles ]
then
	mkdir /app/configfiles
fi
ln -s /app/configfiles /home/steamuser/Zomboid
	
# Launch Server
# Variables pulled from Docker environment
cd /app
./start-server.sh