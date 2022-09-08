FROM php:7.4-fpm

# get latest package list
RUN apt-get update

# intall dependencies
RUN apt-get install -y --no-install-recommends \
    libfreetype6-dev \
    libicu-dev \
    libjpeg-dev \
    libmagickwand-dev \
    libpng-dev \
    libwebp-dev \
    libzip-dev \
    libcurl4-openssl-dev \
    libonig-dev \
    cron \
    ghostscript \
    zip \
    locales \
    wget \
    nginx

RUN docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg \
    --with-webp

RUN docker-php-ext-install pdo_mysql bcmath curl gd \
    intl json mbstring mysqli opcache xml \
    xmlrpc zip exif

RUN pecl install -o -f imagick redis

RUN docker-php-ext-enable imagick redis

# Copy nginx configuration
COPY nginx.conf /etc/nginx/sites-enabled/default

# Copy entrypoint
COPY entrypoint.sh /etc/entrypoint.sh
RUN chmod +x /etc/entrypoint.sh

# Copy php settings
COPY custom.ini /usr/local/etc/php/conf.d/custom.ini

# install wordpress and pull .git out
WORKDIR /var/www
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xzf latest.tar.gz -C /var/www
RUN rm -r html
RUN mv wordpress html
WORKDIR /var/www/html

# update permissions
# RUN find /var/www/html/wp-content -type d -exec chmod 775 {} \;
# RUN find /var/www/html/wp-content -type f -exec chmod 664 {} \;

# add wordpress cron
RUN crontab -l | { cat; echo "*/10 * * * * /usr/local/bin/php /var/www/html/wp-cron.php?doing_wp_cron >/dev/null 2>&1"; } | crontab -

# locales
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
RUN echo 'bg_BG.UTF-8 UTF-8' >> /etc/locale.gen
RUN echo 'cs_CZ.UTF-8 UTF-8' >> /etc/locale.gen
RUN echo 'hu_HU.UTF-8 UTF-8' >> /etc/locale.gen
RUN echo 'pl_PL.UTF-8 UTF-8' >> /etc/locale.gen
RUN echo 'ro_RO.UTF-8 UTF-8' >> /etc/locale.gen
RUN echo 'ru_RU.UTF-8 UTF-8' >> /etc/locale.gen
RUN echo 'tr_TR.UTF-8 UTF-8' >> /etc/locale.gen
RUN locale-gen

VOLUME [ "/var/www/html" ]

EXPOSE 80

COPY --chown=www-data:www-data wp-config-docker.php /var/www/html

ENTRYPOINT ["sh", "/etc/entrypoint.sh"]