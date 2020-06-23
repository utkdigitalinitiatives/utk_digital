# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

$cpus   = ENV.fetch("ISLANDORA_VAGRANT_CPUS", "2")
$memory = ENV.fetch("ISLANDORA_VAGRANT_MEMORY", "4000")
$hostname = ENV.fetch("ISLANDORA_VAGRANT_HOSTNAME", "islandora")
$forward = ENV.fetch("ISLANDORA_VAGRANT_FORWARD", "TRUE")

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.
  config.vm.provider "virtualbox" do |v|
    v.name = "UTK DI Development VM"
    # Prevent VirtualBox from interfering with host audio stack
    v.customize ["modifyvm", :id, "--audio", "none"]
  end

  config.vm.hostname = $hostname

  # add synced_folder
  config.vm.synced_folder "sites/all", "/vhosts/digital/web/collections/sites/all"

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "utkdigitalbase"
  config.vm.box_url = "http://dlweb.lib.utk.edu/vboxes/utkdigitalbase.json"

  unless  $forward.eql? "FALSE"  
    config.vm.network :forwarded_port, guest: 8080, host: 8080 # Tomcat
    config.vm.network :forwarded_port, guest: 3306, host: 3306 # MySQL
    config.vm.network :forwarded_port, guest: 80, host: 8000 # Apache
  end

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", $memory]
    vb.customize ["modifyvm", :id, "--cpus", $cpus]
  end

  shared_dir = "/vagrant"

  config.vm.provision :shell, path: "./scripts/islandora_modules.sh", :args => shared_dir, :privileged => false
  config.vm.provision :shell, path: "./scripts/islandora_libraries.sh", :args => shared_dir, :privileged => false
  if File.exist?("./scripts/custom.sh") then
    config.vm.provision :shell, path: "./scripts/custom.sh", :args => shared_dir
  end
  config.vm.provision :shell, path: "./scripts/post.sh"
end
