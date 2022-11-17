FROM php:8.1-fpm-alpine

RUN adduser -u 1000 -s /bin/fish -D phpdocker


WORKDIR /www

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN apk update && apk add --no-cache \
    libpng-dev \
    zip \
    libzip-dev \
    jpegoptim optipng pngquant gifsicle \
    unzip \
    curl \
    oniguruma-dev \
    libxml2-dev \
    vim \
    nodejs \
    npm \
    fish
    

RUN docker-php-ext-configure pdo && \
    docker-php-ext-configure pdo_mysql && \
    docker-php-ext-configure zip && \
    docker-php-ext-configure exif && \
    docker-php-ext-configure pcntl && \
    docker-php-ext-configure gd

RUN docker-php-ext-install  pdo \
                            pdo_mysql \
                            zip \
                            exif \
                            pcntl \
                            gd
USER phpdocker


CMD ["php-fpm"]
