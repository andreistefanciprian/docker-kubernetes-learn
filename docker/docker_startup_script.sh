#!/bin/bash

## Upload this script to gs://project-ops/mongo/startup-script.sh

# Capture standard out and standard error in this file
#touch /var/log/capture.txt
exec &> /var/log/capture.txt


## Check if Startup-script has already run - exit if it has
# Check for presence of log file
if [ -f /var/log/startup-script.log ]
then
  echo "/var/log/startup-script.log exists"
  # Check for presence of 'fininhed' string (quiet grep, so there's no console output)
  if grep -q "STARTUP SCRIPT FINISHED" /var/log/startup-script.log
  then
    # Write to log and exit cleanly
    echo "Startup Script has already completed - exiting."
    echo "$(date) : Startup Script has already completed - exiting." >> /var/log/startup-script.log
    exit 0
  else
    # Something might be wrong later in this script
    echo "Startup Script has run, but may not have completed - Please investigate."
    echo "$(date) : Startup Script has run, but may not have completed - Please investigate." >> /var/log/startup-script.log
  fi
else
  echo "/var/log/startup-script.log doesn't exist"
fi


## Calculate timing and Create Log
# Save Script Start time (current time since epoch)
scriptstarttime=`date +%s`
# Create & Write log
touch /var/log/startup-script.log
cat >> /var/log/startup-script.log << EOT
########################## STARTUP SCRIPT STARTED ########################
Startup script started: $(date)
Script start time: $scriptstarttime seconds since epoch
##########################################################################
EOT


# SET UP THE REPOSITORY
sudo apt-get update
sudo apt-get install -y \
apt-transport-https \
ca-certificates \
curl \
software-properties-common
# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Verify docker fingerprint key
sudo apt-key fingerprint 0EBFCD88

# setup repo
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update
sudo apt-get install -y docker-ce


# Use docker as non root user
sudo groupadd docker
sudo usermod -aG docker cipcirip

# Stat Docker on boot
sudo systemctl enable docker
# sudo chkconfig docker on

# Docker postinstall:
# https://docs.docker.com/install/linux/linux-postinstall/

## Calculate timings and write to log
# Save Script timings
scriptendtime=`date +%s`
scripttime=$((($scriptendtime) - ($scriptstarttime)))
cat >> /var/log/startup-script.log << EOT
######################### STARTUP SCRIPT FINISHED ########################
Startup Script has finished. It will not run again fully as long as the line above exists in this file.
Startup Script finished: $(date)
Instance Startup Script: $scripttime seconds
Use these figures to set Cooldown or Initial Delay values.
##########################################################################
EOT
