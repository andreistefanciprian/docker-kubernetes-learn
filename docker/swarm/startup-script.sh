#! /bin/bash


# Create log file
LOG_FILE="/var/log/startup-script.log"
touch $LOG_FILE


# Output errors in the log file
exec 2>> $LOG_FILE


echo "========= START OF STARTUP SCRIPT" >> $LOG_FILE


echo '--------- Install basic packages' >> $LOG_FILE
apt-get update
echo "deb http://archive.ubuntu.com/ubuntu bionic main universe" >> /etc/apt/sources.list
echo "deb http://archive.ubuntu.com/ubuntu bionic-security main universe" >> /etc/apt/sources.list
echo "deb http://archive.ubuntu.com/ubuntu bionic-updates main universe" >> /etc/apt/sources.list
apt-get update


echo '--------- Install packages to allow apt to use a repository over HTTPS' >> $LOG_FILE
apt-get install -y \
apt-transport-https \
ca-certificates \
curl \
gnupg-agent \
software-properties-common


echo '--------- Add Docker’s official GPG key' >> $LOG_FILE
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -


echo '--------- Set up the stable repository' >> $LOG_FILE
add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) \
stable"


echo "--------- Install docker" >> $LOG_FILE
# apt-get install docker-ce docker-ce-cli containerd.io
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh


echo "--------- Use docker as a non root user" >> $LOG_FILE
usermod -aG docker cipcirip


echo "========= END OF STARTUP SCRIPT" >> $LOG_FILE