# Juste like the ci
FROM php:8.1-apache

#Install System Packages
RUN apt-get update && apt install -y libzip-dev unzip zlib1g-dev libicu-dev libsqlite3-dev sqlite3 libpng-dev libjpeg-dev libfreetype6-dev git wget gnupg libmagickwand-dev 

#Install PHP Extensions
RUN docker-php-ext-install pdo_sqlite pdo_mysql zip pcntl intl gd

RUN pecl install apcu xdebug imagick
RUN docker-php-ext-enable apcu xdebug imagick

RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs

RUN a2enmod proxy_fcgi ssl rewrite

USER www-data

EXPOSE 80
EXPOSE 8000

CMD ["apache2-foreground"]
