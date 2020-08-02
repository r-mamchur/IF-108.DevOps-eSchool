# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
#      ans.vm.provision "ansible_local" do |ansible|
#      db.vm.network "public_network"
Vagrant.configure("2") do |config| 

   config.vagrant.host = "windows"
#       не тестити на наявність нового образу
   config.vm.box_check_update = false
   config.ssh.insert_key = false


   config.vm.define "my" do |my|
      my.vm.box = "centos/8"
      my.vm.hostname = 'my8'
      my.vm.network "private_network", ip: "192.168.56.11"
      my.vm.provider "virtualbox" do |vb|
         vb.memory = "1024"
      end
      my.vm.provision "shell", inline: "chmod 0777 /vagrant/*.sh"
      my.vm.provision "shell", path: "root_ssh.sh"	
      my.vm.provision "shell", inline: <<-SHELL
         yum update -y
         yum install -y mysql-server
         systemctl start mysqld.service
         systemctl enable mysqld.service

         echo "CREATE DATABASE eschool DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci; " | mysql
         echo "CREATE USER 'eschool'@'%' IDENTIFIED BY 'Passw0rd('; " | mysql
         echo "GRANT ALL ON eschool.* TO 'eschool'@'%' WITH GRANT OPTION; " | mysql
SHELL
   end

   config.vm.define "be" do |be|
      be.vm.box = "centos/7"
      be.vm.hostname = 'be'
      be.vm.network "private_network", ip: "192.168.56.13"
      be.vm.provider "virtualbox" do |vb|
         vb.memory = "2048"
      end
      be.vm.provision "shell", inline: "chmod 0777 /vagrant/*.sh"
      be.vm.provision "shell", path: "root_ssh.sh"	
      be.vm.provision "shell", path: "be.sh"	
   end

   config.vm.define "fe" do |fe|
      fe.vm.box = "centos/7"
      fe.vm.hostname = 'fe'
      fe.vm.network "private_network", ip: "192.168.56.14"
      fe.vm.provider "virtualbox" do |vb|
         vb.memory = "1024"
      end
      fe.vm.provision "shell", inline: "chmod 0777 /vagrant/*.sh"
      fe.vm.provision "shell", path: "root_ssh.sh"	
      fe.vm.provision "shell", path: "fe5.sh"	
   end

end

