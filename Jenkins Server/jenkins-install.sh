#!/bin/bash
set -e

# update system
sudo dnf update -y

# install java (Amazon Linux 2023 -> use corretto)
sudo dnf install -y java-17-amazon-corretto

# install jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo dnf upgrade -y
sudo dnf install -y jenkins
echo "tmpfs /tmp tmpfs defaults,size=2G 0 0" >> /etc/fstab
mount -o remount /tmp

# configure jenkins to listen on all interfaces
if grep -q "JENKINS_LISTEN_ADDRESS" /etc/sysconfig/jenkins; then
  sudo sed -i 's|JENKINS_LISTEN_ADDRESS=.*|JENKINS_LISTEN_ADDRESS="0.0.0.0"|' /etc/sysconfig/jenkins
else
  echo 'JENKINS_LISTEN_ADDRESS="0.0.0.0"' | sudo tee -a /etc/sysconfig/jenkins
fi

# enable & start jenkins
sudo systemctl enable jenkins
sudo systemctl restart jenkins

# install git
sudo dnf install -y git

# install terraform
sudo dnf install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo dnf install -y terraform

# install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.23.6/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
