FROM ubuntu:trusty
MAINTAINER Jochen Lillich <jochen@freistil.it>

# Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
  apt-get -y install \
    apache2 \
    git \
    libapache2-mod-php5 \
    mysql-server \
    php-apc \
    php5-curl \
    php5-gd \
    php5-mcrypt \
    php5-mysql \
    pwgen \
    supervisor \
  && apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Image setup scripts
ADD run.sh /run.sh

# Apache
ADD apache/start.sh /setup/apache-start.sh
ADD apache/default_vhost.conf /etc/apache2/sites-available/000-default.conf
ADD apache/supervisord.conf /etc/supervisor/conf.d/supervisord-apache2.conf
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN a2enmod rewrite

# MySQL
ADD mysql/init.sh /setup/init/10-mysql.sh
ADD mysql/init/* /setup/init/mysql/
ADD mysql/start.sh /setup/mysql-start.sh
ADD mysql/my.cnf /etc/mysql/conf.d/my.cnf
ADD mysql/supervisord.conf /etc/supervisor/conf.d/supervisord-mysqld.conf
RUN rm -rf /var/lib/mysql/*
VOLUME /var/lib/mysql

# PHP
ENV PHP_UPLOAD_MAX_FILESIZE 10M
ENV PHP_POST_MAX_SIZE 10M
ADD php/init.sh /setup/init/10-php.sh

# Expose HTTP and MySQL ports
EXPOSE 80 3306

# Boot container
RUN chmod 755 /run.sh
CMD ["/run.sh"]
