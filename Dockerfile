FROM ubuntu:14.04
RUN sudo apt-get update && sudo apt-get install -y --force-yes default-jre mysql-client

COPY UnlimitedJCEPolicy /usr/lib/jvm/java-7-openjdk-amd64/jre/lib/
COPY domibus /opt/domibus
COPY config/init.sh /opt/domibus/bin/

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64/jre

# Domibus MySql hostname
ENV DMBSQLSVR mysql

# Domibus MySql root password
ENV DMBSQLPWD links6:toner

# Open ports to the container

 # Domibus app
EXPOSE 8080

 # JBoss management console
EXPOSE 9990

 # JMS Messaging
EXPOSE 5445

 # JMS Messaging througput
EXPOSE 5455

RUN ["/bin/chmod", "750", "/opt/domibus/bin/init.sh"]

ENTRYPOINT ["/opt/domibus/bin/init.sh"]

CMD []