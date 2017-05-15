# Lucee Docker Workbench

Docker workbench project template for a Lucee development pipeline; export files to use as the base for Lucee development in a containerised world.

**For more information on this Docker Workbench project format, see the [Daemonite Docker Workbench Project](https://github.com/justincarter/docker-workbench) and [my tutorial on setting up the Workbench](https://labs.daemon.com.au/t/daemon-docker-workbench/295).**


## Installation

Dependencies: Running `docker-machine`, see https://github.com/justincarter/docker-workbench

```
git clone https://github.com/modius/lucee-docker-workbench
cd lucee-docker-workbench
docker-compose up
```

The location depends on your set up but it will either be the VMs IP address or the workbench URL you are using for Lucee development:
```
open http://lucee.192.168.99.100.nip.io/
```

Lucee admin is open (ie. insecure) and uses the password `docker`:

```
open http://lucee.192.168.99.100.nip.io/lucee/admin/web.cfm
```


## Anatomy of the Project

The project structure provides an environment for local Docker development, and a process for building images for production deployment.

```
lucee-docker-workbench/
├── docker-compose.yml
├── Dockerfile
├── .dockerignore
├── project
├── config
│   ├── lucee
│   │   └── lucee-web.xml.cfm
│   └── nginx
│       ├── conf.d
│       │   └── default.conf
│       └── nginx.conf
└── logs
```

`docker-compose.yml`
Defines how your container should spin up; including environment variables and volumes.

`./Dockerfile`
A sample Dockerfile for building a Lucee application. Use this to build an image externally for deployment.  Make sure that the contents of `code` are replicated here otherwise your container will only work locally.

`./code`
The `code` directory is set up as a **git submodule** pointing to a simple lucee test app. Change this to reflect the code base you want to develop with.  Anything under the `code` directory is sync'd into the container via a volume to allow development.

_Note, you will need to update your Dockerfile with the same code base in order to build your image for deployment._

`./config`
Config files for customising the container.  The container needs to be re-built any time you make changes to these configuration files.

`./logs`
The example container will automatically write logs into this directory tree to make development easier. Logs are transient and should never be committed to the repo.  The logs are mapped via the volumes nominated in the `docker-compose.yml`.


## Tips

Getting Lucee configs from container:
```
docker ps
docker cp 74f0485da60d:/opt/lucee/server/lucee-server/context/lucee-server.xml ./lucee-server.xml
docker cp 74f0485da60d:/opt/lucee/web/lucee-web.xml.cfm ./lucee-web.xml.cfm
```