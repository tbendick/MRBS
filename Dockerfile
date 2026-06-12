FROM php:8.4-apache

RUN a2enmod rewrite \
 && apt-get update \
 && apt-get install -y --no-install-recommends libicu-dev locales-all \
 && docker-php-ext-install mysqli pdo pdo_mysql intl \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN { \
      echo 'ServerName localhost'; \
    } > /etc/apache2/conf-available/servername.conf \
 && a2enconf servername

COPY web/ /var/www/html/
COPY docker-config.inc.php /var/www/html/config.inc.php
