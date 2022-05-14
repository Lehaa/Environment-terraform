#!/bin/bash

ip_address=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
sudo echo "Hello world from following $ip_address > /var/www/html/index.html

sudo systemctl restart httpd