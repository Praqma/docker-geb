#!/bin/bash
cd /home/jenkins/site/

# running `jekyll serve` in background
exec 3< <(jekyll serve &)
# waiting for server is ready
sed '/Server running/q' <&3 ; cat <&3 &
echo "Got respond from server, running tests..."
groovy ./tests/main.groovy
