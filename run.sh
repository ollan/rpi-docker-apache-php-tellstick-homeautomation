#!/bin/bash

# install app
[[ ! -d "/var/www/html/.svn" ]] && \
	svn co svn://karpero.mine.nu/homeautomation /var/www/html
 
# update
svn update /var/www/html

# excutable
find /var/www/html -iname "*.php" | xargs chmod +x

#test
echo test >> /var/www/html/test.txt

source /etc/apache2/envvars
exec apache2 -D FOREGROUND
