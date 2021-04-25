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
#sudo yum install -y java-1.8.0-openjdk
sudo amazon-linux-extras install java-openjdk11
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

#Build backend service
cd /home/ec2-user/Website/blog-website
gradle build
sudo docker build --build-arg JAR_FILE=build/libs/*.jar -t erw444/blog-website .

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
L2Jpbi9kb2NrZXItY29tcG9zZQoKI0luc3RhbGwgR3JhZGxlCiNzdWRvIHl1bSBp
bnN0YWxsIC15IGphdmEtMS44LjAtb3BlbmpkawpzdWRvIGFtYXpvbi1saW51eC1l
eHRyYXMgaW5zdGFsbCBqYXZhLW9wZW5qZGsxMQpzdWRvIHl1bSBpbnN0YWxsIC15
IHdnZXQgdW56aXAKY2QgL3RtcApzdWRvIHdnZXQgaHR0cHM6Ly9zZXJ2aWNlcy5n
cmFkbGUub3JnL2Rpc3RyaWJ1dGlvbnMvZ3JhZGxlLTYuMy1iaW4uemlwCnVuemlw
IGdyYWRsZS0qLnppcApzdWRvIG1rZGlyIC9vcHQvZ3JhZGxlCnN1ZG8gY3AgLXBy
IGdyYWRsZS0qLyogL29wdC9ncmFkbGUKc3VkbyBlY2hvICJleHBvcnQgUEFUSD0v
b3B0L2dyYWRsZS9iaW46JHtQQVRIfSIgfCBzdWRvIHRlZSAvZXRjL3Byb2ZpbGUu
ZC9ncmFkbGUuc2gKc3VkbyBjaG1vZCAreCAvZXRjL3Byb2ZpbGUuZC9ncmFkbGUu
c2gKc291cmNlIC9ldGMvcHJvZmlsZS5kL2dyYWRsZS5zaAoKI0luc3RhbGwgbm9k
ZQpjdXJsIC0tc2lsZW50IC0tbG9jYXRpb24gaHR0cHM6Ly9ycG0ubm9kZXNvdXJj
ZS5jb20vc2V0dXBfMTIueCB8IHN1ZG8gYmFzaCAtCnN1ZG8geXVtIGluc3RhbGwg
LXkgbm9kZWpzCnN1ZG8geXVtIGluc3RhbGwgLXkgZ2l0CgojRGVwbG95IHdlYnNp
dGUKY2QgL2hvbWUvZWMyLXVzZXIKZ2l0IGNsb25lIGh0dHBzOi8vZ2l0aHViLmNv
bS9lcnc0NDQvV2Vic2l0ZS5naXQKCiNCdWlsZCBkaXNjb3Zlcnkgc2VydmljZQpj
ZCAvaG9tZS9lYzItdXNlci9XZWJzaXRlL2Rpc2NvdmVyeQpncmFkbGUgYnVpbGQK
c3VkbyBkb2NrZXIgYnVpbGQgLS1idWlsZC1hcmcgSkFSX0ZJTEU9YnVpbGQvbGli
cy8qLmphciAtdCBlcnc0NDQvZGlzY292ZXJ5IC4KCiNCdWlsZCBmcm9udGVuZCBz
ZXJ2aWNlCmNkIC9ob21lL2VjMi11c2VyL1dlYnNpdGUvd2Vic2l0ZS1mcm9udGVu
ZC9zcmMvbWFpbi9yZXNvdXJjZXMvc3RhdGljCm5wbSBpbnN0YWxsCmNkIC9ob21l
L2VjMi11c2VyL1dlYnNpdGUvd2Vic2l0ZS1mcm9udGVuZApncmFkbGUgYnVpbGQK
c3VkbyBkb2NrZXIgYnVpbGQgLS1idWlsZC1hcmcgSkFSX0ZJTEU9YnVpbGQvbGli
cy8qLmphciAtdCBlcnc0NDQvd2Vic2l0ZS1mcm9udGVuZCAuCgojQnVpbGQgYmFj
a2VuZCBzZXJ2aWNlCmNkIC9ob21lL2VjMi11c2VyL1dlYnNpdGUvYmxvZy13ZWJz
aXRlCmdyYWRsZSBidWlsZApzdWRvIGRvY2tlciBidWlsZCAtLWJ1aWxkLWFyZyBK
QVJfRklMRT1idWlsZC9saWJzLyouamFyIC10IGVydzQ0NC9ibG9nLXdlYnNpdGUg
LgoKY2QgL2hvbWUvZWMyLXVzZXIvV2Vic2l0ZQpzdWRvIGRvY2tlci1jb21wb3Nl
IHVw