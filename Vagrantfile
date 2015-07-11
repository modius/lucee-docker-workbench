VAGRANTFILE_API_VERSION = "2"
WORKBENCH_IP = "192.168.33.11"
Vagrant.require_version ">= 1.6.3"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  ##################################################
  # Start Docker host
  ##################################################
  config.vm.define "dockerhost", autostart: false do |dh|
    dh.vm.box = "dduportal/boot2docker"
    dh.vm.network "private_network", ip: "192.168.33.11"
    dh.vm.synced_folder ".", "/vagrant", type: "virtualbox"

    # Map Docker VM service ports to VM host
    dh.vm.network :forwarded_port, :host => 48000, :guest => 8000
    dh.vm.network :forwarded_port, :host => 443, :guest => 443

    dh.vm.provider "virtualbox" do |virtualbox|
      virtualbox.memory = 2048
    end
    #dh.vm.provision :shell, :inline => "sleep 5"
  end

  ##################################################
  # Launch containers
  ##################################################
  config.vm.define "lucee", autostart: true do |lucee|
    lucee.vm.provider "docker" do |docker|
      docker.name = "lucee"
      docker.build_dir = "./docker/lucee"
      docker.volumes = %w(/vagrant/code:/var/www)
      docker.volumes = [
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
