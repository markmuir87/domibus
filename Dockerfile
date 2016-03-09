FROM alpine:3.2

COPY domibus /opt/domibus
COPY config/init.sh /opt/domibus/bin/
COPY config/start.sh /opt/domibus/bin/

# Domibus MySql hostname
ENV DMBSQLSVR localhost

# Domibus MySql root password
ENV DMBSQLPWD password

ENV JAVA_HOME /usr/lib/jvm/default-jvm/jre

# Open ports to the container

 # Domibus app
EXPOSE 8080

 # JBoss management console
EXPOSE 9990

 # JMS Messaging
EXPOSE 5445

 # JMS Messaging througput
EXPOSE 5455

RUN ["apk", "update"]
RUN ["apk", "add", "openjdk7"]
RUN apk add mysql mysql-client && \
	mv /usr/share/mysql/mysql.server /etc/init.d/mysql && \
	/usr/bin/mysql_install_db --user=mysql --datadir=/var/lib/mysql && \
	service -i mysql start && \
    /usr/bin/mysqladmin -u root password password && \
    service -i mysql stop
RUN ["apk", "add", "bash"]
RUN ["mkdir", "/var/lib/domibus"]
RUN ["/bin/chmod", "750", "/opt/domibus/bin/init.sh"]
RUN ["/bin/chmod", "750", "/opt/domibus/bin/start.sh"]
RUN ["/opt/domibus/bin/init.sh"]

COPY UnlimitedJCEPolicy ${JAVA_HOME}/lib/

VOLUME /opt/domibus/certificates
VOLUME /opt/domibus/modules/eu/domibus/main
VOLUME /opt/domibus/pmodes
VOLUME /var/lib/domibus
VOLUME /var/lib/mysql/edelivery

ENTRYPOINT ["/opt/domibus/bin/start.sh"]

CMD []
