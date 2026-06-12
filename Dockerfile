FROM php:8.4-apache

RUN a2enmod rewrite \
 && apt-get update \
 && apt-get install -y --no-install-recommends default-mysql-client libicu-dev locales-all \
 && docker-php-ext-install mysqli pdo pdo_mysql intl \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN { \
      echo 'ServerName localhost'; \
    } > /etc/apache2/conf-available/servername.conf \
 && a2enconf servername

COPY web/ /var/www/html/
COPY docker-config.inc.php /var/www/html/config.inc.php
COPY tables.my.sql /opt/mrbs/sql/tables.my.sql
COPY docs/fdny-room-seed.my.sql /opt/mrbs/sql/fdny-room-seed.my.sql
COPY docs/fdny-sample-bookings.my.sql /opt/mrbs/sql/fdny-sample-bookings.my.sql
COPY docker-entrypoint.sh /usr/local/bin/mrbs-docker-entrypoint
RUN chmod +x /usr/local/bin/mrbs-docker-entrypoint
ENTRYPOINT ["mrbs-docker-entrypoint"]
CMD ["apache2-foreground"]
