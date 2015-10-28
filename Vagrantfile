##################################################
# Workbench Settings
##################################################
Vagrant.require_version ">= 1.7.3"

PROJECT_ENV = File.basename(Dir.getwd)

if File.exist?('../Vagrantfile')
  WORKBENCH_HOST = "workbench"
  WORKBENCH_VAGRANTFILE = "../Vagrantfile"
else
  WORKBENCH_HOST = "dockerhost"
  WORKBENCH_VAGRANTFILE = __FILE__
end

Vagrant.configure("2") do |config|

  ##################################################
  # Launch dev containers
  # - vagrant up lucee
  ##################################################
  config.vm.define "lucee", autostart: true do |lucee|
    lucee.vm.provider "docker" do |docker|
      docker.name = PROJECT_ENV
      docker.build_dir = "."
      docker.env = {
        VIRTUAL_HOST: PROJECT_ENV + ".*, lucee.*"
      }
      # local development code, lucee config & logs
      docker.volumes = [
        "/vagrant/" + PROJECT_ENV + "/code:/var/www",
        "/vagrant/" + PROJECT_ENV + "/config/lucee/lucee-web.xml.cfm:/opt/lucee/web/lucee-web.xml.cfm",
        "/vagrant/" + PROJECT_ENV + "/logs/lucee:/opt/lucee/web/logs",
        "/vagrant/" + PROJECT_ENV + "/logs/nginx:/var/log/nginx",
        "/vagrant/" + PROJECT_ENV + "/logs/supervisor:/var/log/supervisor",
        "/vagrant/" + PROJECT_ENV + "/logs/tomcat:/usr/local/tomcat/logs"
        ]
      docker.vagrant_machine = WORKBENCH_HOST
      docker.vagrant_vagrantfile = WORKBENCH_VAGRANTFILE
      docker.force_host_vm = true
    end
    puts '############################################################'
    puts '# ' + PROJECT_ENV.upcase
    puts '#  - hosted at: http://' + PROJECT_ENV + '.dev'
    puts '############################################################'
  end


  ##################################################
  # Solo Docker Host; 
  #   fallback for missing parent boot2docker env
  ##################################################
  config.vm.define "dockerhost", autostart: false do |dh|
    dh.vm.box = "dduportal/boot2docker"
    dh.vm.network "private_network", ip: "192.168.56.100"
    dh.vm.synced_folder ".", "/vagrant/" + PROJECT_ENV, type: "virtualbox"

    dh.vm.provider "virtualbox" do |vb|
      vb.memory = 2048
      vb.customize ["modifyvm", :id, "--nictype2", "virtio"]
    end

    puts '############################################################'
    puts '#  WARNING: BACKUP HOST... http://192.168.56.100'
    puts '# '
    puts '#  Could not find Workbench Boot2Docker. Consider Setting'
    puts '#  up the complete development environment:'
    puts '#    https://github.com/Daemonite/workbench'
    puts '############################################################'
  end

# /config
end