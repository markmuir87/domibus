#!/usr/bin/env bash

if ! service mysql status; then
	service mysql start
fi

if [ ! -f /var/lib/domibus/init.done ]; then
	# Initialise mysql database
	/usr/bin/mysql -h localhost -u root --password=password -e "drop schema if exists edelivery;create schema edelivery;alter database edelivery charset=utf8; create user 'edelivery'@'localhost' identified by 'edelivery';grant all on edelivery.* to edelivery;"

	# Create domibus database
	mysql -h localhost -u root --password=password edelivery < /opt/domibus/sql-scripts/create-mysql.sql

	# Set the mysql hostname
	# /bin/sed -i.bak 's/jdbc:mysql:\/\/localhost/jdbc:mysql:\/\/'"$DMBSQLSVR"'/' /opt/domibus/standalone/configuration/standalone.xml

	touch /var/lib/domibus/init.done
fi
