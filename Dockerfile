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
  php5-mcrypt \
  php5-mysql \
  pwgen \
  supervisor

# Image setup scripts
ADD run.sh /run.sh

# Apache
ADD apache/start.sh /setup/apache-start.sh
ADD apache/default_vhost.conf /etc/apache2/sites-available/000-default.conf
ADD apache/supervisord.conf /etc/supervisor/conf.d/supervisord-apache2.conf
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN a2enmod rewrite

# MySQL
ADD mysql/start.sh /setup/mysql-start.sh
ADD mysql/init_db.sh /setup/mysql-init_db.sh
ADD mysql/setup.sh /setup/mysql-setup.sh
ADD mysql/create_admin_user.sh /setup/mysql-create_admin_user.sh
ADD mysql/my.cnf /etc/mysql/conf.d/my.cnf
ADD mysql/supervisord.conf /etc/supervisor/conf.d/supervisord-mysqld.conf
RUN rm -rf /var/lib/mysql/*
VOLUME /var/lib/mysql

# PHP
ENV PHP_UPLOAD_MAX_FILESIZE 10M
ENV PHP_POST_MAX_SIZE 10M
ADD php/setup.sh /setup/php-setup.sh

# Expose HTTP and MySQL ports
EXPOSE 80 3306

# Boot container
RUN chmod 755 /run.sh /setup/*.sh
CMD ["/run.sh"]
