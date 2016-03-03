#!/usr/bin/env bash

# Initialise mysql database
/usr/bin/mysql -h $DMBSQLSVR -u root --password=$DMBSQLPWD -e "drop schema if exists edelivery;create schema edelivery;alter database edelivery charset=utf8; create user edelivery identified by 'edelivery';grant all on edelivery.* to edelivery;"

# Create domibus database
mysql -h $DMBSQLSVR -u root --password=$DMBSQLPWD edelivery < /opt/domibus/sql-scripts/create-mysql.sql

# Set the mysql hostname
/bin/sed -i.bak 's/jdbc:mysql:\/\/localhost/jdbc:mysql:\/\/'"$DMBSQLSVR"'/' /opt/domibus/standalone/configuration/standalone.xml

sh /opt/domibus/bin/standalone.sh
