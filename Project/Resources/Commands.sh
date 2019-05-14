# From AWS_EC2-2019.pdf

chmod 400 Path/To/Pem   # Path to .pem file

ssh -i Path/To/Pem ec2-user@EC2_Link   # Replace EC2_Link

sudo yum install tomcat7-webapps tomcat-docs-webapp tomcat7-admin-webapps

sudo nano /etc/tomcat7/tomcat-users.xml

sudo service tomcat7 start

# If one is programming in Java 8 instead of Java 7, run these commands in EC2.

sudo yum install java-1.8.0

sudo yum remove java-1.7.0-openjdk

sudo service tomcat7 restart