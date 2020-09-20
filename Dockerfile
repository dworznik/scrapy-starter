FROM python:3.8-buster

ARG BASIC_AUTH

RUN apt-get update -qq \
 && apt-get install --no-install-recommends -y \
    nginx apache2-utils \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

 RUN pip install git+https://github.com/necrophcodr/chaperone.git \
 && mkdir /etc/chaperone.d

RUN pip install scrapyd

ADD chaperone.conf /etc/chaperone.d/chaperone.conf
ADD nginx.conf /etc/nginx/sites-enabled/default
ADD scrapyd.conf /etc/scrapyd/scrapyd.conf

RUN echo $BASIC_AUTH > /etc/nginx/htpasswd
ADD nginx.conf /etc/nginx/sites-enabled/default

ENTRYPOINT ["/usr/local/bin/chaperone"]
