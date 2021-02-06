#!/bin/bash
yum install -y java-1.8.0-openjdk-devel wget git
export JAVA_HOME=/etc/alternatives/java_sdk_1.8.0
wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
yum install -y apache-maven
git clone https://github.com/tellisnz/terraform-aws.git
cd terraform-aws/sample-web-app/server
echo "CMD- mvn spring-boot:run -Dspring.datasource.url=jdbc:postgresql://"${this_db_instance_address}:${db_port}/${db_name}" -Dspring.datasource.username="${db_username}" -Dspring.datasource.password="${db_password}" -Dserver.port="${app_port}"
mvn spring-boot:run -Dspring.datasource.url=jdbc:postgresql://"${this_db_instance_address}:${db_port}/${db_name}" -Dspring.datasource.username="${db_username}" -Dspring.datasource.password="${db_password}" -Dserver.port="${app_port}" &