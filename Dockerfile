# Juste like the ci
FROM php:7.4-apache

#Install System Packages
RUN docker-php-ext-install pdo pdo_mysql
RUN apt-get update \
    && apt-get install -y libzip-dev \
    && apt-get install -y zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

#Install PHP Extensions
RUN docker-php-ext-install zip

#RUN wget https://get.symfony.com/cli/installer -O - | bash
#RUN mv /root/.symfony/bin/symfony /usr/local/bin/symfony

RUN apt-get update && apt-get upgrade -y

USER www-data

EXPOSE 80
EXPOSE 8000

CMD ["apache2-foreground"]
