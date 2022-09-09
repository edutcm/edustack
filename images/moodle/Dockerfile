FROM php:7.4-fpm

# ARGS
ARG VERSION

# ENV
ENV MOODLE_DB_PASSWORD=password
ENV MOODLE_HOSTNAME=moodle.local

# Install extensions
RUN apt-get update \
    && apt-get install -y aspell clamav curl graphviz ghostscript git \
    libcurl4-openssl-dev zlib1g-dev libpng-dev libicu-dev libonig-dev \
    libpspell-dev libxml2-dev libzip-dev libmagickwand-dev libldap2-dev \
    libjpeg-dev libfreetype6-dev libwebp-dev \
    rsync openssh-client cron locales curl git wget \
    nginx gnutls-bin \
    --no-install-recommends

RUN docker-php-ext-configure ldap --with-libdir=lib/$(uname -m)-linux-gnu/

RUN docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg \
    --with-webp

RUN docker-php-ext-install pdo_mysql bcmath curl gd \
    intl ldap mbstring mysqli opcache pspell soap xml \
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

# change workdir
WORKDIR /home/root

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- \
--install-dir=/usr/bin --filename=composer

# Install moosh
RUN git clone https://github.com/tmuras/moosh.git
WORKDIR /home/root/moosh
RUN composer install
RUN ln -s $PWD/moosh.php /usr/local/bin/moosh

# Download Moodle
WORKDIR /var/www
RUN git clone https://github.com/moodle/moodle.git
WORKDIR /var/www/moodle
RUN git branch --track MOODLE_${VERSION}_STABLE origin/MOODLE_${VERSION}_STABLE
RUN git checkout MOODLE_${VERSION}_STABLE
WORKDIR /var/www
RUN rm -r html
RUN mv moodle html
COPY config.php /var/www/html/config.php

# Change to Moodle dir
WORKDIR /var/www/html

# Update permissions
RUN chown -R www-data:www-data /var/www/html
RUN mkdir /var/moodledata \
    && chmod 0777 /var/moodledata \
    && chown www-data:www-data /var/moodledata

# Moodle Cron
RUN crontab -l | { cat; echo "* * * * * /usr/local/bin/php /var/www/html/admin/cli/cron.php >/dev/null"; } | crontab -
RUN crontab -l | { cat; echo "*/5 * * * * /usr/bin/flock -n '/tmp/moodledata.lock' -c 'rsync -ah --info=progress2 -L /var/moodledata/* /var/opt/moodledata_data --delete-after --ignore-errors' >/dev/null"; } | crontab -

# Locales
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
RUN echo 'bg_BG.UTF-8 UTF-8' >> /etc/locale.gen
RUN echo 'cs_CZ.UTF-8 UTF-8' >> /etc/locale.gen
RUN echo 'hu_HU.UTF-8 UTF-8' >> /etc/locale.gen
RUN echo 'pl_PL.UTF-8 UTF-8' >> /etc/locale.gen
RUN echo 'ro_RO.UTF-8 UTF-8' >> /etc/locale.gen
RUN echo 'ru_RU.UTF-8 UTF-8' >> /etc/locale.gen
RUN echo 'tr_TR.UTF-8 UTF-8' >> /etc/locale.gen
RUN locale-gen

VOLUME [ "/var/www/html", "/var/moodledata" ]

# Expose http
EXPOSE 80

#RUN service cron start
ENTRYPOINT ["sh", "/etc/entrypoint.sh"]