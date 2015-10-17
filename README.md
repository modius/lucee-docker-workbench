# Lucee Docker Workbench

Vagrant based Docker workbench for a Lucee development pipeline.  This is a project template that can be exported and used as the basis for Lucee development in a containerised world.


## Installation

Dependencies: Virtualbox, `git v1.6.5`, `vagrant v1.7.3` (install all of these first!)

```
git clone --recursive https://github.com/modius/lucee-docker-workbench
cd lucee-docker-workbench
vagrant up lucee
```

The location depends on your set up but it will either be the VMs IP address or the workbench URL if you are using the [Daemonite Docker Workbench](https://github.com/daemonite/workbench) for Lucee development:
```
open http://192.168.56.100:9000/
or
open http://workbench:9000/
```

_Note, the Vagrant box dduportal/boot2docker is about 30Mb and the lucee container image is about 500Mb so you need to download 530Mb to get things going.  If you have a mediocre internet connection you might want to think about taking lunch. These only need to be downloaded the once._

## Anatomy of the Project

The project structure provides an environment for local Docker development, and a process for building images for production deployment.

```
lucee-docker-workbench/
├── Dockerfile
├── LICENSE
├── README.md
├── Vagrantfile
├── code (-> git submodule)
├── config
│   ├── lucee
│   │   └── lucee-web.xml.cfm
│   └── nginx
│       ├── conf.d
│       │   └── default.conf
│       └── nginx.conf
└── logs
    ├── lucee
    ├── nginx
    ├── supervisor
    └── tomcat
```

`Vagrantfile`
Split into two parts: the **dockerhost** virtual machine running Docker 1.7 and a separate container definition for running the **lucee** container.

- `vagrant up lucee` - brings the environment up and running
- `vagrant reload lucee` to rebuild the container image on demand (ignore any errors)

`./Dockerfile`
A sample Dockerfile for building a Lucee application. Use this to build an image externally for deployment.  Make sure that the contents of `code` are replicated here otherwise your container will only work locally.

`./code`
The `code` directory is set up as a **git submodule** pointing to a simple lucee test app. Change this to reflect the code base you want to develop with.  Anything under the `code` directory is sync'd into the container via a volume to allow development.

_Note, you will need to update your Dockerfile with the same code base in order to build your image for deployment._

`./config`
Config files for customising the container.  The container needs to be re-built any time you make changes to these configuration files.

`./logs`
The example container will automatically write logs into this directory tree to make development easier. Logs are transient and should never be committed to the repo.  The logs are mapped via the volumes nominated in the `Vagrantfile`.

## Troubleshooting

Sometimes when you are mucking around with your container you get an image built but not properly deployed.

You might get an error like this:
```
Stderr: Error response from daemon: Conflict. The name "lucee" is already in use by container 0dc57610816b. You have to delete (or rename) that container to be able to reuse that name.
```

If you check the status of your vagrant set up with `vagrant status` you may see the lucee container in a "preparing" state:
```
$ vagrant status
Current machine states:

dockerhost                running (virtualbox)
lucee                     preparing (docker)
```

If this happens, you need to manually clean up the containers and `vagrant up lucee` again.  Manual clean-up is pretty simple if you know your way about:

Logon to the Boot2Docker VM:
```
$ vagrant ssh dockerhost
```

List all the containers:
```
docker@boot2docker:~$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                CREATED             STATUS              PORTS               NAMES
0dc57610816b        a97ead0ec4bf        "supervisord -c /etc   11 minutes ago                                              lucee
```

Remove the rogue container:
```
docker@boot2docker:~$ docker rm lucee
lucee
```