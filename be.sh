#!/bin/bash

echo 'pwd' $(pwd) >/vagrant/lll
echo 'id' $(id) >>/vagrant/lll
echo 'home' $HOME >>/vagrant/lll

yum update -y
yum install java-1.8.0-openjdk-devel wget git -y

wget https://apache.paket.ua/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
tar xzvf apache-maven-3.6.3-bin.tar.gz -C /opt/

export PATH=/opt/apache-maven-3.6.3/bin:$PATH
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.252.b09-2.el7_8.x86_64

mvn --version  >>/vagrant/lll

git clone https://github.com/yurkovskiy/eSchool /vagrant/eSchool

app='/vagrant/eSchool/src/main/resources/application.properties'
sed -i -e "s|localhost:3306/|192.168.56.11:3306/|g" $app
sed -i -e "s|DATASOURCE_USERNAME:root|DATASOURCE_USERNAME:eschool|g" $app
sed -i -e "s|DATASOURCE_PASSWORD:root|DATASOURCE_PASSWORD:Passw0rd(|g" $app
sed -i -e "s|https://fierce-shore-32592.herokuapp.com|http://192.168.56.13|g" $app

app_prod='/vagrant/eSchool/src/main/resources/application-production.properties'
sed -i -e "s|35.242.199.77:3306/|192.168.56.11:3306/|g" $app_prod
sed -i -e "s|DATASOURCE_USERNAME:root|DATASOURCE_USERNAME:eschool|g" $app_prod
sed -i -e "s|DATASOURCE_PASSWORD:CS5eWQxnja0lAESd|DATASOURCE_PASSWORD:Passw0rd(|g" $app_prod
sed -i -e "s|https://35.240.41.176:8443|http://192.168.56.13|g" $app_prod

cd /vagrant/eSchool 
mvn package -DskipTests	

cd /vagrant/eSchool/target
java -jar eschool.jar >/tmp/eschool.log 2>/tmp/eschool.log &
 


