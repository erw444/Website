#!/bin/bash
sudo yum update -y

#Add Docker
sudo amazon-linux-extras install docker
sudo service docker start
sudo docker info

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

#Grab discovery server
cd /home/ec2-user
git clone https://github.com/erw444/discovery.git
cd /home/ec2-user/discovery
gradle build

sudo docker build --build-arg JAR_FILE=build/libs/*.jar -t erw444/discovery .
sudo docker run -d -p 8761:8761 erw444/discovery

#Grab website frontend
cd /home/ec2-user
git clone https://github.com/erw444/website-frontend.git
cd /home/ec2-user/website-frontend/src/main/resources/static
npm install
cd /home/ec2-user/website-frontend
gradle build

sudo docker build --build-arg JAR_FILE=build/libs/*.jar -t erw444/website-frontend .
sudo docker run -d -p 8080:5000 erw444/website-frontend

# The above commands base64 encoded for entering into UserData
IyEvYmluL2Jhc2gKc3VkbyB5dW0gdXBkYXRlIC15CgojQWRkIERvY2tlcgpzdWRv
IGFtYXpvbi1saW51eC1leHRyYXMgaW5zdGFsbCBkb2NrZXIKc3VkbyBzZXJ2aWNl
IGRvY2tlciBzdGFydApzdWRvIGRvY2tlciBpbmZvCgojSW5zdGFsbCBHcmFkbGUK
c3VkbyB5dW0gaW5zdGFsbCAteSBqYXZhLTEuOC4wLW9wZW5qZGsKc3VkbyB5dW0g
aW5zdGFsbCAteSB3Z2V0IHVuemlwCmNkIC90bXAKc3VkbyB3Z2V0IGh0dHBzOi8v
c2VydmljZXMuZ3JhZGxlLm9yZy9kaXN0cmlidXRpb25zL2dyYWRsZS02LjMtYmlu
LnppcAp1bnppcCBncmFkbGUtKi56aXAKc3VkbyBta2RpciAvb3B0L2dyYWRsZQpz
dWRvIGNwIC1wciBncmFkbGUtKi8qIC9vcHQvZ3JhZGxlCnN1ZG8gZWNobyAiZXhw
b3J0IFBBVEg9L29wdC9ncmFkbGUvYmluOiR7UEFUSH0iIHwgc3VkbyB0ZWUgL2V0
Yy9wcm9maWxlLmQvZ3JhZGxlLnNoCnN1ZG8gY2htb2QgK3ggL2V0Yy9wcm9maWxl
LmQvZ3JhZGxlLnNoCnNvdXJjZSAvZXRjL3Byb2ZpbGUuZC9ncmFkbGUuc2gKCiNJ
bnN0YWxsIG5vZGUKY3VybCAtLXNpbGVudCAtLWxvY2F0aW9uIGh0dHBzOi8vcnBt
Lm5vZGVzb3VyY2UuY29tL3NldHVwXzEyLnggfCBzdWRvIGJhc2ggLQpzdWRvIHl1
bSBpbnN0YWxsIC15IG5vZGVqcwpzdWRvIHl1bSBpbnN0YWxsIC15IGdpdAoKI0dy
YWIgZGlzY292ZXJ5IHNlcnZlcgpjZCAvaG9tZS9lYzItdXNlcgpnaXQgY2xvbmUg
aHR0cHM6Ly9naXRodWIuY29tL2VydzQ0NC9kaXNjb3ZlcnkuZ2l0CmNkIC9ob21l
L2VjMi11c2VyL2Rpc2NvdmVyeQpncmFkbGUgYnVpbGQKCnN1ZG8gZG9ja2VyIGJ1
aWxkIC0tYnVpbGQtYXJnIEpBUl9GSUxFPWJ1aWxkL2xpYnMvKi5qYXIgLXQgZXJ3
NDQ0L2Rpc2NvdmVyeSAuCnN1ZG8gZG9ja2VyIHJ1biAtZCAtcCA4NzYxOjg3NjEg
ZXJ3NDQ0L2Rpc2NvdmVyeQoKI0dyYWIgd2Vic2l0ZSBmcm9udGVuZApjZCAvaG9t
ZS9lYzItdXNlcgpnaXQgY2xvbmUgaHR0cHM6Ly9naXRodWIuY29tL2VydzQ0NC93
ZWJzaXRlLWZyb250ZW5kLmdpdApjZCAvaG9tZS9lYzItdXNlci93ZWJzaXRlLWZy
b250ZW5kL3NyYy9tYWluL3Jlc291cmNlcy9zdGF0aWMKbnBtIGluc3RhbGwKY2Qg
L2hvbWUvZWMyLXVzZXIvd2Vic2l0ZS1mcm9udGVuZApncmFkbGUgYnVpbGQKCnN1
ZG8gZG9ja2VyIGJ1aWxkIC0tYnVpbGQtYXJnIEpBUl9GSUxFPWJ1aWxkL2xpYnMv
Ki5qYXIgLXQgZXJ3NDQ0L3dlYnNpdGUtZnJvbnRlbmQgLgpzdWRvIGRvY2tlciBy
dW4gLWQgLXAgODA4MDo1MDAwIGVydzQ0NC93ZWJzaXRlLWZyb250ZW5kCg==