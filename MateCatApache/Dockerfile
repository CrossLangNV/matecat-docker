FROM ostico/trusty-base:latest

# Prepare the environment
ENV PHP_POST_MAX_SIZE 1024M
ENV PHP_UPLOAD_MAX_FILESIZE 1024M
ENV PHP_MAX_MEMORY 4096M
ENV DEBIAN_FRONTEND noninteractive

ENV SERVICES_DIR "/etc/init.d"
ENV USER_OWNER "www-data"
ENV MATECAT_HOME "/var/www/matecat"

# Copy matecat source code
COPY matecat /var/www/matecat

# Make sure there's a matecat/local_storage folder
RUN mkdir -p /var/www/matecat/local_storage

COPY ./app_configs/config.ini /tmp/config.ini
COPY ./app_configs/node_config.ini /tmp/node_config.ini
COPY ./app_configs/Error_Mail_List.ini /tmp/Error_Mail_List.ini

# Google OAuth
COPY ./app_configs/oauth_config.ini /tmp/oauth_config.ini

COPY ./app_configs/task_manager_config.ini /tmp/task_manager_config.ini

# Node.js v8.x
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
RUN apt-get install -y nodejs

# Monit
COPY monitrc /etc/monit/monitrc

# Moreutils: for sponge
RUN apt-get install -y moreutils

# Apache
RUN mkdir /var/log/apache2/matecat/
RUN rm -rf /etc/apache2/sites-available/default
RUN rm -rf /etc/apache2/sites-enabled/*
RUN userdel www-data
RUN groupadd www-data
RUN useradd -ms /bin/bash -g www-data www-data

## ENABLE Deployment utils ( apache follows symbolic links to DocumentRoot )
RUN apt-get update
RUN apt-get install -y apache2 php5-dev php5-mcrypt
RUN git clone https://github.com/etsy/mod_realdoc.git
WORKDIR "/mod_realdoc"
RUN apxs2 -i -a -c mod_realdoc.c
WORKDIR "/"
RUN rm -rf ./mod_realdoc

## Enable MateCat site
COPY 000-matecat.conf /etc/apache2/sites-enabled/000-matecat.conf
RUN a2enmod rewrite filter deflate headers expires proxy_http.load
RUN php5enmod mcrypt

# Start app_configslication
COPY run.sh /tmp/run.sh
RUN chmod +x /tmp/run.sh

WORKDIR "/var/www/matecat"
CMD ["/tmp/run.sh"]