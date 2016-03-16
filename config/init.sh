#!/usr/bin/env bash

if ! service mysql status; then
	service mysql start
fi

if [ ! -f /var/lib/domibus/init.done ]; then
	# Initialise mysql database


	# Create domibus database
	mysql -h localhost -u root --password=password domibus < /opt/domibus/sql-scripts/mysql5innoDb-initial.ddl
	mysql -h localhost -u root --password=password domibus < /opt/domibus/sql-scripts/mysql5innoDb-quartz.ddl

	# Set the mysql hostname
	# /bin/sed -i.bak 's/jdbc:mysql:\/\/localhost/jdbc:mysql:\/\/'"$DMBSQLSVR"'/' /opt/domibus/standalone/configuration/standalone.xml

	touch /var/lib/domibus/init.done
fi
