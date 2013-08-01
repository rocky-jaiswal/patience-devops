#Setup
------

$ sudo apt-get install git

$ wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb

$ sudo dpkg -i puppetlabs-release-precise.deb

$ sudo apt-get update

$ sudo apt-get install puppet-common

$ git clone https://github.com/rocky-jaiswal/patience-devops.git

$ cd patience-devops

$ chmod u+x setup.sh

$ ./setup.sh


Add User One
------------
useradd rockyj -s /bin/bash

mkdir /home/rockyj

chown -R rockyj /home/rockyj

passwd rockyj

usermod -aG sudo rockyj

ssh-keygen -t rsa -C "nomail@gmail.com"
