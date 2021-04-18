#!/bin/bash
sudo yum update -y

#Add Docker
sudo amazon-linux-extras install docker
sudo service docker start
sudo docker info

sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose version
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

#Install Gradle
sudo yum install -y java-1.8.0-openjdk
sudo yum install -y wget unzip
cd /tmp
sudo wget https://services.gradle.org/distributions/gradle-6.3-bin.zip
unzip gradle-*.zip
sudo mkdir /opt/gradle
sudo cp -pr gradle-*/* /opt/gradle
sudo echo "export PATH=/opt/gradle/bin:${PATH}" | sudo tee /etc/profile.d/gradle.sh
sudo chmod +x /etc/profile.d/gradle.sh
source /etc/profile.d/gradle.sh

#Install node
curl --silent --location https://rpm.nodesource.com/setup_12.x | sudo bash -
sudo yum install -y nodejs
sudo yum install -y git

#Deploy website
cd /home/ec2-user
git clone https://github.com/erw444/Website.git

#Build discovery service
cd /home/ec2-user/Website/discovery
gradle build
sudo docker build --build-arg JAR_FILE=build/libs/*.jar -t erw444/discovery .

#Build frontend service
cd /home/ec2-user/Website/website-frontend/src/main/resources/static
npm install
cd /home/ec2-user/Website/website-frontend
gradle build
sudo docker build --build-arg JAR_FILE=build/libs/*.jar -t erw444/website-frontend .

cd /home/ec2-user/Website
sudo docker-compose up

# The above commands base64 encoded for entering into UserData
IyEvYmluL2Jhc2gKc3VkbyB5dW0gdXBkYXRlIC15CgojQWRkIERvY2tlcgpzdWRv
IGFtYXpvbi1saW51eC1leHRyYXMgaW5zdGFsbCBkb2NrZXIKc3VkbyBzZXJ2aWNl
IGRvY2tlciBzdGFydApzdWRvIGRvY2tlciBpbmZvCgpzdWRvIGN1cmwgLUwgaHR0
cHM6Ly9naXRodWIuY29tL2RvY2tlci9jb21wb3NlL3JlbGVhc2VzL2xhdGVzdC9k
b3dubG9hZC9kb2NrZXItY29tcG9zZS0kKHVuYW1lIC1zKS0kKHVuYW1lIC1tKSAt
byAvdXNyL2xvY2FsL2Jpbi9kb2NrZXItY29tcG9zZQpzdWRvIGNobW9kICt4IC91
c3IvbG9jYWwvYmluL2RvY2tlci1jb21wb3NlCmRvY2tlci1jb21wb3NlIHZlcnNp
b24Kc3VkbyBsbiAtcyAvdXNyL2xvY2FsL2Jpbi9kb2NrZXItY29tcG9zZSAvdXNy
L2Jpbi9kb2NrZXItY29tcG9zZQoKI0luc3RhbGwgR3JhZGxlCnN1ZG8geXVtIGlu
c3RhbGwgLXkgamF2YS0xLjguMC1vcGVuamRrCnN1ZG8geXVtIGluc3RhbGwgLXkg
d2dldCB1bnppcApjZCAvdG1wCnN1ZG8gd2dldCBodHRwczovL3NlcnZpY2VzLmdy
YWRsZS5vcmcvZGlzdHJpYnV0aW9ucy9ncmFkbGUtNi4zLWJpbi56aXAKdW56aXAg
Z3JhZGxlLSouemlwCnN1ZG8gbWtkaXIgL29wdC9ncmFkbGUKc3VkbyBjcCAtcHIg
Z3JhZGxlLSovKiAvb3B0L2dyYWRsZQpzdWRvIGVjaG8gImV4cG9ydCBQQVRIPS9v
cHQvZ3JhZGxlL2Jpbjoke1BBVEh9IiB8IHN1ZG8gdGVlIC9ldGMvcHJvZmlsZS5k
L2dyYWRsZS5zaApzdWRvIGNobW9kICt4IC9ldGMvcHJvZmlsZS5kL2dyYWRsZS5z
aApzb3VyY2UgL2V0Yy9wcm9maWxlLmQvZ3JhZGxlLnNoCgojSW5zdGFsbCBub2Rl
CmN1cmwgLS1zaWxlbnQgLS1sb2NhdGlvbiBodHRwczovL3JwbS5ub2Rlc291cmNl
LmNvbS9zZXR1cF8xMi54IHwgc3VkbyBiYXNoIC0Kc3VkbyB5dW0gaW5zdGFsbCAt
eSBub2RlanMKc3VkbyB5dW0gaW5zdGFsbCAteSBnaXQKCiNEZXBsb3kgd2Vic2l0
ZQpjZCAvaG9tZS9lYzItdXNlcgpnaXQgY2xvbmUgaHR0cHM6Ly9naXRodWIuY29t
L2VydzQ0NC9XZWJzaXRlLmdpdAoKI0J1aWxkIGRpc2NvdmVyeSBzZXJ2aWNlCmNk
IC9ob21lL2VjMi11c2VyL1dlYnNpdGUvZGlzY292ZXJ5CmdyYWRsZSBidWlsZApz
dWRvIGRvY2tlciBidWlsZCAtLWJ1aWxkLWFyZyBKQVJfRklMRT1idWlsZC9saWJz
LyouamFyIC10IGVydzQ0NC9kaXNjb3ZlcnkgLgoKI0J1aWxkIGZyb250ZW5kIHNl
cnZpY2UKY2QgL2hvbWUvZWMyLXVzZXIvV2Vic2l0ZS93ZWJzaXRlLWZyb250ZW5k
L3NyYy9tYWluL3Jlc291cmNlcy9zdGF0aWMKbnBtIGluc3RhbGwKY2QgL2hvbWUv
ZWMyLXVzZXIvV2Vic2l0ZS93ZWJzaXRlLWZyb250ZW5kCmdyYWRsZSBidWlsZApz
dWRvIGRvY2tlciBidWlsZCAtLWJ1aWxkLWFyZyBKQVJfRklMRT1idWlsZC9saWJz
LyouamFyIC10IGVydzQ0NC93ZWJzaXRlLWZyb250ZW5kIC4KCmNkIC9ob21lL2Vj
Mi11c2VyL1dlYnNpdGUKc3VkbyBkb2NrZXItY29tcG9zZSB1cA==