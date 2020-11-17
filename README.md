# pz-server
Docker container for a Project Zomboid Dedicated Server

Build to create a containerized version of the dedicated server for Project Zomboid
https://projectzomboid.com/blog/
 
 
Build by hand
```
git clone https://github.com/antimodes201/pz-server.git
docker build -t antimodes201/pz-server:latest .
``` 
 
Docker Pull
```
docker pull antimodes201/pz-server
```
 
Docker Run with defaults (10 players)
change the volume options to a directory on your node and maybe use a admin and password then the one in the example
 
```
docker run -it -p 16261:16261/udp -p 16262:16272/tcp -v /app/docker/temp-vol:/app \
-e SERVERNAME="default" \
-e PASSWORD="password123" \
--name pz-server \
antimodes201/pz-server:latest
```
 
To allow more then 10 players extend the port range by the number of players (16262 + # of players).  EG for 20 players:
```
docker run -it -p 16261:16261/udp -p 16262:16282/tcp -v /app/docker/temp-vol:/app \
-e SERVERNAME="default" \
-e PASSWORD="password123" \
--name pz-server \
antimodes201/pz-server:latest
```
 
To change the save name from the default servertest use the 
World save and config files are commited to a directory called configfiles at the root of your mounted volume.
 
Currently exposed environmental variables and their default values
- SERVERNAME default
- PASSWORD "CHANGEME"
- TZ America/New_York
