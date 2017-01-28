FROM resin/rpi-raspbian:latest
MAINTAINER Johan Axfors <johan@axfors.se>

## Install base packages
RUN apt-get update && \
  apt-get -yq install wget
  
RUN echo "deb http://download.telldus.com/debian/ stable main" >> /etc/apt/sources.list.d/telldus.list && \
    wget -qO - http://download.telldus.se/debian/telldus-public.key | apt-key add -

RUN apt-get update && \ 
    apt-get -yq install \
		apache2 \
		libapache2-mod-php5 \
		curl \
		ca-certificates \
		php5-mysql \
		php5-mcrypt \ 
		php5-gd \
		at \
		telldus-core \
		libtelldus-core2 \
		libtelldus-core-dev \ 
		subversion && \
	apt-get upgrade && \
	apt-get autoremove && \
	apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archive/*.deb

RUN /usr/sbin/php5enmod mcrypt && a2enmod rewrite

ADD ./000-default.conf /etc/apache2/sites-available/000-default.conf
ADD ./run.sh /run.sh
RUN chmod 755 /*.sh && chown -R www-data:www-data /var/www/html

# Add volumes
VOLUME /var/www/html /tmp

EXPOSE 80
CMD ["/run.sh"]
