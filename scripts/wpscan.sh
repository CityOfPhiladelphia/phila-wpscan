#!/bin/bash

> /home/ubuntu/app/wpscan-results.txt

cd ~/app/wpscan

# load rvm ruby
source /home/ubuntu/.rvm/environments/ruby-2.3.1@wpscan
source /home/ubuntu/.ssh/environment

# Update WPScan
ruby /home/ubuntu/app/wpscan/wpscan.rb --update

while read NAME
do
    ruby /home/ubuntu/app/wpscan/wpscan.rb --url $NAME --no-color --batch >> /home/ubuntu/app/wpscan-results.txt

done < /home/ubuntu/app/wpscan-targets.txt

/usr/local/bin/aws sns publish --topic-arn "$AWS_SNS_ID" --message file:///home/ubuntu/app/wpscan-results.txt
