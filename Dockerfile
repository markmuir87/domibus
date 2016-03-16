FROM alpine:3.2

# Domibus MySql hostname
ENV DMBSQLSVR localhost

# Domibus MySql root password
ENV DMBSQLPWD password

ENV JAVA_HOME /usr/lib/jvm/default-jvm/jre
ENV CATALINA_HOME /opt/domibus
ENV CATALINA_PID /opt/domibus/tomcat.pid
ENV JAVA_OPTS="-Ddomibus.config.location=/opt/domibus/conf/domibus"

# Open ports to the container

 # Domibus app
EXPOSE 8080

 # JBoss management console
EXPOSE 9990

 # JMS Messaging
EXPOSE 5445

 # JMS Messaging througput
EXPOSE 5455

 # MySQL
EXPOSE 3306

COPY domibus-tomcat-3.1.0/domibus /opt/domibus
COPY domibus-tomcat-3.1.0/sql-scripts /opt/domibus/sql-scripts
COPY config/start.sh /opt/domibus/bin/

RUN apk update

RUN apk add mysql mysql-client openjdk7 bash wget && \
	mv /usr/share/mysql/mysql.server /etc/init.d/mysql && \
	/usr/bin/mysql_install_db --user=mysql --datadir=/var/lib/mysql

COPY UnlimitedJCEPolicy /usr/lib/jvm/default-jvm/jre/lib/

RUN	service -i mysql start && \
    /usr/bin/mysqladmin -u root password password && \
    /usr/bin/mysql -h localhost -u root --password=password -e "drop schema if exists domibus;create schema domibus;alter database domibus charset=utf8; create user 'domibus'@'localhost' identified by 'changeit'; create user 'domibus'@'%' identified by 'changeit';grant all on domibus.* to domibus;" && \
	mysql -h localhost -u root --password=password domibus < /opt/domibus/sql-scripts/mysql5innoDb-initial.ddl  && \
	mysql -h localhost -u root --password=password domibus < /opt/domibus/sql-scripts/mysql5innoDb-quartz.ddl && \
	service -i mysql stop

RUN	/usr/bin/wget -O /opt/domibus/common/lib/mysql-connector-java-5.0.8.jar http://central.maven.org/maven2/mysql/mysql-connector-java/5.0.8/mysql-connector-java-5.0.8.jar && \
	/bin/chmod 750 /opt/domibus/bin/start.sh && \
	/bin/chmod 750 /opt/domibus/bin/catalina.sh

VOLUME /opt/domibus/certificates
VOLUME /opt/domibus/modules/eu/domibus/main
VOLUME /opt/domibus/pmodes
VOLUME /var/lib/mysql/domibus

ENTRYPOINT ["/opt/domibus/bin/start.sh"]

CMD []
