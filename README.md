# Lucee Docker Workbench

Vagrant based Docker workbench for a Lucee development pipeline.  This is a project template that can be exported and used as the basis for Lucee development in a containerised world.


## Installation

Dependencies: Virtualbox, `git v1.6.5`, `vagrant v1.6.3`

```
git clone --recursive https://github.com/modius/mod-env-workbench
cd mod-env-workbench
vagrant up
open http://192.168.33.11:8000/
```

## Anatomy of the Project

The project structure provides an environment for local Docker development, and a process for building images for production deployment.

```
├── Vagrantfile
├── code
├── docker
│   └── lucee
│       ├── Dockerfile
│       ├── lucee
│       │   └── lucee-web.xml.cfm
│       └── nginx
│           ├── conf.d
│           │   └── default.conf
│           └── nginx.conf
└── logs
```

`Vagrantfile`
Split into two parts: the **dockerhost** virtual machine running Docker 1.7 and a separate container definition for running the **lucee** container.

- `vagrant up` - brings the environment up and running
- `vagrant reload lucee` followed by `vagrant up` to rebuild the container image on demand (ignore any errors)

`./code`
The `code` directory is set up as a **git submodule** pointing to a simple lucee test app. Change this to reflect the code base you want to develop with.  Anything under the `code` directory is sync'd into the container via a volume to allow development.

_Note, you will need to update your Dockerfile with the same code base in order to build your image for deployment._

`./docker`
Docker container build and configuration. Create a subdirectory for each container, or variation of container.  The container build location is nominated in the `Vagrantfile`.


`./docker/lucee`
Example Lucee based container for development.  Sub-directories house the various config files for customising the container.  The container needs to be re-built any time you make changes to these configuration files.

`./docker/lucee/Dockerfile`
A sample Dockerfile for building a Lucee application. Use this to build an image externally for deployment.  Make sure that the contents of `code` are replicated here otherwise your container will only work locally.

`./logs`
The example container will automatically write logs into this directory tree to make development easier. Logs are transient and should never be committed to the repo.  The logs are mapped via the volumes nominated in the `Vagrantfile`.