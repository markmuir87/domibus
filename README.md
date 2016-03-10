[Markdown Cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)

# E-Delivery project
A docker file to build an self contained ebMS3/AS4 message service handler based on Domibus.
The image includes a mysql instance.

The domibus distribution must be in the ./domibus directory. Create a softlink when building in a Unix environment.

Build this image with the following command:

`docker build --rm=true -t mhvdboog/domibus .`

The repository contains one docker file for the domibus app and depends on the domibus app being available in the docker context.

[Download the domibus distribution here](https://joinup.ec.europa.eu/nexus/content/repositories/releases/eu/europa/ec/cipa/cef-edelivery-distribution/3.2.0-alpha-1/cef-edelivery-distribution-3.2.0-alpha-1-as4-jboss.zip)

## Start domibus
`docker run --name domibus -p 8080:8080 -p 9990:9990 -p 5445:5445 -p 5455:5455 -d mhvdboog/domibus`
