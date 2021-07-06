FROM maven:3.6.0-jdk-8

RUN apt-get update
RUN apt-get install -y git

COPY config.properties /tmp/config.properties
COPY defaultSegmentation.judicio-v7.srx /root/custom-srx/defaultSegmentation.judicio-v7.srx

COPY startFilter.sh /tmp/startFilter.sh
RUN chmod +x /tmp/startFilter.sh
CMD ["/tmp/startFilter.sh"]
