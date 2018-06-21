FROM openjdk:8-jre

WORKDIR /
ENV GITHUB_TAG=v1.4.0.1
ENV VERSION=1.4.0
ENV GATEWAY_HOST=TB-HOST
ENV GATEWAY_ACCESS_TOKEN=YOUR_TOKEN

RUN wget https://github.com/thingsboard/thingsboard-gateway/releases/download/$GITHUB_TAG/tb-gateway-$VERSION.deb -O tb-gateway.deb \
	&& dpkg -i tb-gateway.deb \
	# Copying env variables into conf files
	&& printenv | awk -F "=" '{print "export " $1 "='\''" $2 "'\''"}' >> /usr/share/tb-gateway/conf/tb-gateway.conf \
	&& cat /usr/share/tb-gateway/conf/tb-gateway.conf \
	&& echo "Starting 'TB-gateway' service..." \
	&& service tb-gateway start \
	# Wait until log file is created
	&& sleep 5 \
	&& tail -f /var/log/tb-gateway/tb-gateway.log
