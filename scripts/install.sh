#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
sudo apt-get update

echo 'Installing dependencies';
sudo apt-get install libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev git unzip

# AWS install thanks to GSF
echo 'Installing AWS CLI'
cd /tmp
wget https://s3.amazonaws.com/aws-cli/awscli-bundle.zip
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
cd -

echo 'Configuring AWS CLI'
mkdir -p ~/.aws
cat > ~/.aws/config <<EOF
[default]
aws_access_key_id = $AWS_ID
aws_secret_access_key = $AWS_SECRET
region = us-east-1
EOF

# As recommended by RVM
echo 'Installing RVM'
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
echo "source ~/.rvm/scripts/rvm" >> ~/.bashrc
rvm install 2.3.1
rvm use 2.3.1 --default
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
#gem install bundler

echo 'Cloning WPScan'
cd ~/app
git clone https://github.com/wpscanteam/wpscan.git
cd wpscan
gem install bundler
bundle install --without test

# One liner thanks to http://stackoverflow.com/questions/878600/how-to-create-cronjob-using-bash
echo 'Adding cronjob'
(crontab -l ; echo "0 9 * * * /home/ubuntu/app/scripts/wpscan.sh") | crontab -
