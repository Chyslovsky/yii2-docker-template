FROM php:7.2-fpm

MAINTAINER Maksym Churkyn <imaximius@gmail.com>

 # Set timezone
RUN echo Europe/Kiev >/etc/timezone \
    && ln -snf /usr/share/zoneinfo/Europe/Kiev /etc/localtime && echo Europe/Kiev > /etc/timezone \
    && echo 'date.timezone=Europe/Kiev' >> /usr/local/etc/php/conf.d/timezone.ini

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libssl-dev \
    cron \
    systemd \
    supervisor \
    librabbitmq-dev \
    mysql-client \
    zlib1g-dev \
    libxml2-dev \
    libfreetype6-dev \
    libjpeg-dev \
    libxpm-dev \
    libpng-dev \
    libicu57 \
    libxslt1.1 \
    libmemcachedutil2

RUN docker-php-ext-install -j$(nproc) iconv  \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ --with-xpm-dir=/usr/include/ --enable-gd-native-ttf --enable-gd-jis-conv \
    && docker-php-ext-install -j$(nproc) gd

# Install extentions
RUN docker-php-ext-configure intl
RUN docker-php-ext-install pdo pdo_mysql bcmath intl mbstring zip soap

# Install AMPQ ext
RUN pecl install amqp \
    && docker-php-ext-enable amqp

# install mongodb ext
RUN pecl install mongodb \
        && docker-php-ext-enable mongodb


# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version

# Install wkhtmltopdf
RUN apt-get update \
    && apt-get -y install wkhtmltopdf

# Install NodeJS
RUN apt-get install -y gnupg \
    && curl -sL https://deb.nodesource.com/setup_8.x | bash \
    && apt-get install -y npm \
    && npm i npm@latest -g

# Install Opcache
RUN docker-php-ext-install opcache \
    && echo 'opcache.enable=1' >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
    && echo 'opcache.fast_shutdown=0' >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
    && echo 'opcache.memory_consumption=512' >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
    && echo 'opcache.interned_strings_buffer=64' >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
    && echo 'opcache.max_accelerated_files=32531' >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
    && echo 'opcache.save_comments=1' >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini

RUN if ! $DEBUG; then echo 'opcache.validate_timestamps=0' >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini; fi

# Set PHP common config
RUN echo 'session.gc_maxlifetime=86400' >> /usr/local/etc/php/conf.d/docker-php-common.ini \
    && echo 'memory_limit = 512M' >> /usr/local/etc/php/conf.d/docker-php-common.ini \
    && echo 'post_max_size = 64M' >> /usr/local/etc/php/conf.d/docker-php-common.ini \
    && echo 'upload_max_filesize = 64M' >> /usr/local/etc/php/conf.d/docker-php-common.ini \
    && echo 'max_file_uploads = 20' >> /usr/local/etc/php/conf.d/docker-php-common.ini

# Install composer
RUN apt-get install -y unzip \
 && curl -sS https://getcomposer.org/installer | php \
 && mv composer.phar /usr/local/bin/composer \
 && chmod +x /usr/local/bin/composer