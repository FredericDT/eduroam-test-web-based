FROM library/debian:bullseye

RUN sed -i -E 's+(deb|security).debian.org+mirrors.bupt.edu.cn+g' /etc/apt/sources.list

ENV RADIUS_SERVER=127.0.0.1
ENV CLIENT_SECRET=mysecret

# ENV APACHE_RUN_DIR=/var/run/apache2
# ENV APACHE_PID_FILE=/var/run/apache2/apache2.pid
# ENV APACHE_LOCK_DIR=/var/lock/apache2
# ENV APACHE_RUN_USER=www-data
# ENV APACHE_RUN_GROUP=www-data
# ENV APACHE_LOG_DIR=/var/log/apache2

COPY ./html /var/www/html
RUN chmod a+x /var/www/html/cgi-bin/eduroam-test.cgi 

RUN apt update && apt install -y \ 
    eapoltest apache2 libany-uri-escape-perl && \
    a2enmod cgid 

COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

EXPOSE 80
