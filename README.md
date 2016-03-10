[Markdown Cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)

# E-Delivery project
A docker file to build an self contained ebMS3/AS4 message service handler based on Domibus. This distribution of
Domibus includes a Tomcat server and is based on Domibus version 3.1.0.
The image includes a mysql instance.

Build this image with the following command:

`docker build --rm=true -t mhvdboog/domibus .`

The repository contains one docker file for the domibus app and depends on the domibus app being available in the docker context.

[Download the domibus distribution here](https://joinup.ec.europa.eu/nexus/service/local/repositories/releases/content/eu/domibus/domibus-tomcat-full/3.1-beta/domibus-tomcat-full-3.1-beta.zip)

## Start domibus
`docker run --name domibus -p 8080:8080 -p 9990:9990 -p 5445:5445 -p 5455:5455 -d mhvdboog/domibus`
