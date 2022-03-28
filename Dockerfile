FROM httpd:latest

RUN  apt-get update -y

#ARG DEBIAN_FRONTEND=noninteractive

RUN  apt-get install -y apache2

COPY index.html /usr/local/apache2/htdocs/index.html

CMD apachectl -DFOREGROUND 

