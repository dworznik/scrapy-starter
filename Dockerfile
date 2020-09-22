FROM python:3.8-buster

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


ARG USER_BASIC_AUTH
ARG ADMIN_BASIC_AUTH

RUN echo $USER_BASIC_AUTH > /etc/nginx/user.htpasswd
RUN echo $ADMIN_BASIC_AUTH >> /etc/nginx/user.htpasswd
RUN echo $ADMIN_BASIC_AUTH > /etc/nginx/admin.htpasswd
ADD nginx.conf /etc/nginx/sites-enabled/default

ENTRYPOINT ["/usr/local/bin/chaperone"]
