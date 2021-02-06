#!/bin/bash
# install git/nginx
yum install -y git gettext nginx
echo "NETWORKING=yes" >/etc/sysconfig/network

# install node
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
. /.nvm/nvm.sh
nvm install 6.11.5
# setup sample app client
git clone https://github.com/tellisnz/terraform-aws.git
cd terraform-aws/sample-web-app/client
npm install -g @angular/cli@1.1.0
npm install
export HOME=/root
ng build
rm /usr/share/nginx/html/*
cp dist/* /usr/share/nginx/html/
chown -R nginx:nginx /usr/share/nginx/html

# configure and start nginx
export APP_ELB="${this_elb_dns_name}" APP_PORT="${app_port}" WEB_PORT="${web_port}"
envsubst '$${APP_PORT} $${APP_ELB} $${WEB_PORT}' < nginx.conf.template > /etc/nginx/nginx.conf
service nginx start