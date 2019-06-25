FROM openjdk:8-jre

WORKDIR /
ENV GITHUB_TAG=2.2.1rc
ENV VERSION=2.2.1rc
ENV GATEWAY_HOST=TB-HOST
ENV GATEWAY_ACCESS_TOKEN=YOUR_TOKEN

COPY run.sh /run.sh

RUN wget https://github.com/thingsboard/thingsboard-gateway/releases/download/$GITHUB_TAG/tb-gateway-$VERSION.deb -O tb-gateway.deb \
    && dpkg -i tb-gateway.deb \
    && rm -y tb-gateway.deb \
    && chmod +x /run.sh

VOLUME [ "/usr/share/tb-gateway/conf" ]

CMD /run.sh
