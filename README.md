[Markdown Cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)

# E-Delivery project
A docker file to build an ebMS3/AS4 message service handler based on Domibus.

The repository contains one docker files for the domibus app and depends on the domibus app being available in the docker context.

[Download the domibus distribution here](https://joinup.ec.europa.eu/nexus/content/repositories/releases/eu/europa/ec/cipa/cef-edelivery-distribution/3.2.0-alpha-1/cef-edelivery-distribution-3.2.0-alpha-1-as4-jboss.zip)

## First start mysql docker container based on Oracle MySql image version 5.6
`docker run --name mysql  -p 3306:3306 -e MYSQL_ROOT_PASSWORD=links6:toner -d mysql:5.6`

## Then start domibus and link to the mysql container
`docker run  --name domibus -p 8080:8080 -p 9990:9990 -p 5445:5445 -p 5455:5455 -e MYSQL_ROOT_PASSWORD=links6:toner --link mysql:mysql -d mhvdboog/domibus`
