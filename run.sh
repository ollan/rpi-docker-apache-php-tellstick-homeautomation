#!/bin/bash

# install app
[[ ! -d "/app/.svn" ]] && \
	svn co svn://karpero.mine.nu/homeautomation /app
 
# update
svn update /app

# excutable
find /app -iname "*.php" | xargs chmod +x

#test
echo test >> /app/test.txt

source /etc/apache2/envvars
exec apache2 -D FOREGROUND
