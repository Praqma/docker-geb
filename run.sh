#!/bin/bash
cd /home/jenkins/site/
sudo mkdir /home/jenkins/_site
sudo chmod 777 /home/jenkins/_site/ -R

# running `jekyll serve` in background
exec 3< <(jekyll serve --destination "/home/jenkins/_site"  &)
# waiting for server is ready
sed '/Server running/q' <&3 ; cat <&3 &
echo "Got respond from server, running tests..."
groovy ./tests/main.groovy
