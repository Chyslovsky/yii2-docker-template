#!/usr/bin/env bash

printenv | awk '{split($0,m,"="); print "export "m[1]"=\""m[2]"\""}' >> /root/.bashrc

mkdir --mode=0777 /var/www/web/assets -p
mkdir --mode=0777 /var/www/web/image -p
mkdir --mode=0777 /var/www/web/docs -p
mkdir --mode=0777 /var/www/web/uploads -p


mysql -uroot -p${MYSQL_ROOT_PASSWORD} -h ${MYSQL_HOST} -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE}  CHARACTER SET utf8; \
    GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

chmod -R 0777 /var/www/web

if [  "${CRONTAB}" == true ]; then
    cp supervisor.conf /etc/supervisor/conf.d/ && \
    supervisord
else
    php yii migrate --interactive=0 &&
    chmod -R 0777 /var/www/web
    php-fpm
fi
