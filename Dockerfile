FROM php:8.1.7-apache

RUN apt-get update && apt install -y --no-install-recommends locales apt-utils libzip-dev unzip zlib1g-dev libicu-dev libsqlite3-dev sqlite3 libpng-dev libjpeg-dev libfreetype6-dev git wget gnupg libmagickwand-dev

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen  \
    &&  echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen \
    &&  locale-gen

RUN curl -sS https://getcomposer.org/installer | php -- \
    &&  mv composer.phar /usr/local/bin/composer

RUN curl -sS https://get.symfony.com/cli/installer | bash \
    &&  mv /root/.symfony5/bin/symfony /usr/local/bin

RUN docker-php-ext-configure \
            intl \
    &&  docker-php-ext-install \
            pdo pdo_mysql opcache intl zip calendar dom mbstring gd xsl

RUN pecl install apcu && docker-php-ext-enable apcu

RUN npm install --global yarn

CMD tail -f /dev/null

EXPOSE 80
EXPOSE 8000

WORKDIR /var/www/
COPY . /var/www/