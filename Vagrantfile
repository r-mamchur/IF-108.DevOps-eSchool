# -*- mode: ruby -*-
# vi: set ft=ruby :
num_of_be = 2

Vagrant.configure("2") do |config| 

   config.vagrant.host = "windows"
#       не тестити на наявність нового образу
   config.vm.box_check_update = true
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

   (1..num_of_be).each do |i|
      config.vm.define "be#{i}" do |be|
         be.vm.box = "centos/7"
         be.vm.hostname = "be#{i}"
         be.vm.network "private_network", ip: "192.168.56.13#{i}"
         be.vm.provider "virtualbox" do |vb|
            vb.memory = "1024"
         end
         be.vm.provision "shell", inline: "chmod 0777 /vagrant/*.sh"
         be.vm.provision "shell", path: "root_ssh.sh"	
         be.vm.provision "shell", path: "be.sh"	
      end
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
      fe.vm.provision "shell", path: "fe.sh"	
   end

   config.vm.define "hp" do |hp|
      hp.vm.box = "centos/7"
      hp.vm.hostname = 'hp'
      hp.vm.network "private_network", ip: "192.168.56.21"
      hp.vm.provider "virtualbox" do |vb|
         vb.memory = "1024"
      end
      hp.vm.provision "shell", inline: "chmod 0777 /vagrant/*.sh"
      hp.vm.provision "shell", path: "root_ssh.sh"	
      hp.vm.provision "shell", path: "hp_be.sh"	
   end

end

