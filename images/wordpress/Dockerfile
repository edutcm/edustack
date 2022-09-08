FROM wordpress:6-fpm

# get latest package list
RUN apt-get update

# intall dependencies
RUN apt-get install -y --no-install-recommends \
    locales \
    wget \
    nginx

RUN pecl install -o -f imagick redis

RUN docker-php-ext-enable imagick redis

# Copy nginx configuration
COPY nginx.conf /etc/nginx/sites-enabled/default

# Copy php settings
COPY custom.ini /usr/local/etc/php/conf.d/custom.ini

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

EXPOSE 80

CMD cron; nginx; php-fpm;