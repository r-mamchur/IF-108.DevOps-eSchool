#!/bin/bash

echo 'pwd' $(pwd) >/vagrant/lll
echo 'id' $(id) >>/vagrant/lll
echo 'home' $HOME >>/vagrant/lll

yum update -y
yum install -y mc
yum install yum-utils -y
yum install -y wget
yum install -y unzip
yum install -y git
yum install -y nano
yum install httpd -y
systemctl enable httpd

export PATH=/usr/local/bin:$PATH

cd $HOME
yum install -y gcc-c++ make
wget https://nodejs.org/dist/v9.9.0/node-v9.9.0-linux-x64.tar.gz
tar --strip-components 1 -xzvf node-v* -C /usr/local
npm install -g yarn
npm install -g @angular/cli@7.0.7

git clone https://github.com/yurkovskiy/final_project

sed -i -e "s|https://fierce-shore-32592.herokuapp.com|http://192.168.56.21|g" $HOME/final_project/src/app/services/token-interceptor.service.ts

cd $HOME/final_project
yarn install --network-timeout 1000000
ng build --prod

cp -r $HOME/final_project/dist/eSchool /var/www/

wget https://dtapi.if.ua/~yurkovskiy/IF-108/htaccess_example_fe --output-document=/var/www/eSchool/.htaccess

chmod 777 -R /var/www/
chown -R apache:apache /var/www/

cat <<EOF > /etc/httpd/conf.d/eschool.conf
<VirtualHost *:80>
    DocumentRoot /var/www/eSchool
    ErrorLog /var/log/httpd/eSchool-error.log
    CustomLog /var/log/httpd/eSchool-access.log combined
    <Directory /var/www/eSchool>
        AllowOverride All
    </Directory>
</VirtualHost>
EOF

systemctl restart httpd
 


