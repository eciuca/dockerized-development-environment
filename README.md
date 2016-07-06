# dev-env-setup
A simple and fast way to create a development environment with Jenkins, Nexus, ELK Stash and Kubernetes.

# Prerequisites
- Docker
- Oracle VM VirtualBox Manager (if running on Windows or OSX)

# Getting started for Linux


### Clone the repository
  
  ```
  $ git clone https://github.com/eciuca/dev-env-setup.git
  ```

### Run the containers

Go into the dev-env-setup directory and run the linux configuration
  ```
  $ cd dev-env-setup
  $ docker-compose -f linux/docker-compose.yml up -d
  ```

### Access the default page

Go to `http://localhost/home` (HAProxy is set to listen on port 80, if you want you can change it from docker-compose.yml)

### Configure Nexus

1. Click on the Nexus hyperlink and log in as administrator using the following credentials:
  ```
  username: admin
  password: admin123
  ```

### Configure Go Server and Agent

1. Go to Server administration and configuration> Repository> Repositories and create a new docker (hosted) repository named <b>docker-internal</b>, tick the HTTP box from Repository Connectors and set the port to <b>8444</b> (same as in the file `go/agent/settings.xml`), select the <b>default</b> option for the blob store and click <b>Save</b>

2. Go to `http://localhost` and click the <b>Go</b> hyperlink (`http://localhost/go`). Go to `Admin > Config XML`, click the <b>Edit</b> button and paste the contents of the file `go/server/partial-cruise-config.xml` between the <b>server</b> and <b>agent</b> XML elements (the gocd-agent from the docker-compose.yml should have been already discovered).

### Run a dropwizard-seed image

1. After the gocd-agent finishes successfully the build run the following command to run the newly build docker image
  `$ docker run -p 8888:8888 --log-driver=gelf --log-opt gelf-address=udp://$(docker inspect --format '{{ .NetworkSettings.Networks.linux_default.IPAddress }}' linux_elk_1):12201 --log-opt tag="{{.ImageName}}/{{.Name}}/{{.ID}}" localhost:8444/com.github.eciuca/dropwizard-seed-local`

2. Go to `http://localhost:8888/hello-world/user1` and you should see the following message: `Hello, user1!`

### Access ElasticSearch API

If you make this http request to the elasticsearch node you should see the logs there. Here's the request (you can access from the HAProxy default page): `http://localhost/elasticsearch/_search?pretty`

### Configure Kibana

1. Now if you go to kibana (`http://localhost/app/kibana`) it will redirect you to the Configure an index pattern page. In the index name or patter put <b>gelf_logs</b> and after the <b>Time-field name</b> refreshes select <b>@timestamp</b> from the dropdown and then click <b>Create</b>.

2. If you click now on the <b>Discover</b> navigation button you will be able to see same logs that you have seen at point 9

# Getting started for windows

1. Run prepare.bat
2. Open Oracle VM VirtualBox Manager. Right click your docker machine and map a host port (e.g. 8182) to the internal port 80 (the port to which nginx is listening)
3. docker-compose -f windows-or-osx/docker-compose.yml up (it will start the containers on your active docker machine) - for linux just use the -f linux/docker-compose.yml
4. After the initialization is finished (first time will take about 10 mins for jenkins and 2 mins for nexus maybe because they are downloading and initializing stuff in the specified volumes) you will be able to access Jenkins and Nexus at http://localhost:8182/jenkins and http://localhost:8182/nexus and similar for the others (http://localhost:8182/<app>)

Have fun! :D
