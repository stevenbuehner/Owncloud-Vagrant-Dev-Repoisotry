# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty64"
  config.vm.provision :shell, path: "vagrant_scripts/increase_swap.sh"
  config.vm.provision :shell, path: "vagrant_scripts/install_mysql.sh", env: {"MYSQL_ROOT_PASS" => "adminpass", "MYSQL_ROOT_USER" => "root"}
  config.vm.provision :shell, path: "vagrant_scripts/install_apache2_php5.6.sh"
  config.vm.provision :shell, path: "vagrant_scripts/install_composer.sh"
  config.vm.provision :shell, path: "vagrant_scripts/install_phpunit.sh"
  config.vm.provision :shell, path: "vagrant_scripts/install_owncloud.sh", env: {"MYSQL_ROOT_PASS" => "adminpass", "OWNCLOUD_BRANCH" => "stable9"}
  config.vm.provision :shell, path: "vagrant_scripts/setup_terminal_startdir.sh", privileged: false, env: {"START_DIR" => "/vagrant/www/apps/knowledgebase"}  
  #config.vm.provision :shell, path: "bootstrap.sh"
  config.vm.network :forwarded_port, guest: 80, host: 5000
  config.vm.network :forwarded_port, guest: 3306, host: 5001
  
  # Default share
  config.vm.synced_folder ".", "/vagrant", id: "vagrant-root"
  
    # Sync www to /var/www/html with special owner and group
  config.vm.synced_folder "./data", "/var/www/data", id: "vagrant-data",
    owner: "vagrant",
    group: "www-data",
    mount_options: ["dmode=770,fmode=660"]
  
  # Sync www to /var/www/html with special owner and group
  config.vm.synced_folder "./www", "/var/www/html", id: "vagrant-www",
    owner: "www-data",
    group: "www-data",
    mount_options: ["dmode=777,fmode=776"]

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
