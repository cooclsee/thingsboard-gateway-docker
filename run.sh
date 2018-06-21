#!/bin/bash

# Copying env variables into conf files
printenv | awk -F "=" '{print "export " $1 "='\''" $2 "'\''"}' >> /usr/share/tb-gateway/conf/tb-gateway.conf

cat /usr/share/tb-gateway/conf/tb-gateway.conf

echo "Starting 'TB-gateway' service..."
service tb-gateway start

# Wait until log file is created
sleep 5
tail -f /var/log/tb-gateway/tb-gateway.log