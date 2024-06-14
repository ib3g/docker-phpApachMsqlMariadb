FROM php:8.1.7-apache

RUN apt-get update \
    && apt-get install -y --no-install-recommends locales apt-utils git libicu-dev g++ libpng-dev unzip libxml2-dev libzip-dev zlib1g-dev libonig-dev libxslt-dev wget gnupg libjpeg-dev libmagickwand-dev libfreetype6;

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
            pdo pdo_mysql intl zip calendar dom mbstring gd xsl

RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs

RUN pecl install apcu && docker-php-ext-enable apcu

CMD tail -f /dev/null

EXPOSE 80
EXPOSE 8000

WORKDIR /var/www/
COPY . /var/www/

CMD ["apache2-foreground"]