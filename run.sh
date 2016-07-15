#!/bin/bash
cd /home/jenkins/site/
sudo mkdir _site
sudo chmod 777 _site/
ls -la

# running `jekyll serve` in background
exec 3< <(jekyll serve &)
# waiting for server is ready
sed '/Server running/q' <&3 ; cat <&3 &
echo "Got respond from server, running tests..."
groovy ./tests/main.groovy
