VAGRANTFILE_API_VERSION = "2"
WORKBENCH_IP = "192.168.33.11"

Vagrant.require_version ">= 1.7.3"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  ##################################################
  # Start Docker host
  # - need modern boot2docker image for vagrant; Docker >1.7
  # - https://vagrantcloud.com/dduportal/boxes/boot2docker
  ##################################################
  config.vm.define "dockerhost", autostart: false do |dh|
    dh.vm.box = "dduportal/boot2docker"
    dh.vm.network "private_network", ip: WORKBENCH_IP
    dh.vm.synced_folder ".", "/vagrant", type: "virtualbox"

    # Map Docker VM service ports to VM host
    dh.vm.network :forwarded_port, :host => 8000, :guest => 8000

    dh.vm.provider "virtualbox" do |virtualbox|
      virtualbox.memory = 2048
    end
  end

  ##################################################
  # Launch dev containers
  # - vagrant up lucee
  ##################################################
  config.vm.define "lucee", autostart: true do |lucee|
    lucee.vm.provider "docker" do |docker|
      docker.name = "lucee"
      docker.build_dir = "."
      # local development code, lucee config & logs
      docker.volumes = [
        "/vagrant/code:/var/www",
        "/vagrant/config/lucee/lucee-server.xml:/opt/lucee/server/lucee-server/context/lucee-server.xml",
        "/vagrant/config/lucee/lucee-web.xml.cfm:/opt/lucee/web/lucee-web.xml.cfm",
        "/vagrant/logs/lucee:/opt/lucee/web/logs",
        "/vagrant/logs/nginx:/var/log/nginx",
        "/vagrant/logs/supervisor:/var/log/supervisor",
        "/vagrant/logs/tomcat:/usr/local/tomcat/logs"
        ]
      docker.ports = %w(8000:80)
      docker.vagrant_machine = "dockerhost"
      docker.vagrant_vagrantfile = __FILE__
    end
  end

# /config
end