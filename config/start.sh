#!/usr/bin/env bash

if ! service mysql status; then
	service mysql start
fi

sh /opt/domibus/bin/standalone.sh
