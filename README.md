# dev-env-setup
A simple and fast way to create a development environment with Jenkins, Nexus, ELK Stash and Kubernetes.

# Prerequisites
- Docker
- Oracle VM VirtualBox Manager (if running on Windows or OSX)

# Getting started for windows

1. Run prepare.bat
2. Open Oracle VM VirtualBox Manager. Right click your docker machine and map a host port (e.g. 8182) to the internal port 80 (the port to which nginx is listening)
3. docker-compose -f windows-or-osx/docker-compose.yml up (it will start the containers on your active docker machine) - for linux just use the -f linux/docker-compose.yml
4. After the initialization is finished (first time will take about 10 mins for jenkins and 2 mins for nexus maybe because they are downloading and initializing stuff in the specified volumes) you will be able to access Jenkins and Nexus at http://localhost:8182/jenkins and http://localhost:8182/nexus and similar for the others (http://localhost:8182/<app>)

Have fun! :D
