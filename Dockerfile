# Tahap 1: Build Vendor Dependencies (Composer)
FROM composer:2.6 AS vendor
WORKDIR /app
COPY composer.json composer.lock ./
RUN composer install --no-dev --prefer-dist --no-scripts --no-autoloader --ansi

# Tahap 2: Runtime Image (PHP-FPM & Nginx)
FROM php:8.2-fpm-alpine
WORKDIR /var/www/html

# Install system dependencies & extensions
RUN apk add --no-cache nginx supervisor curl libpng-dev libzip-dev oniguruma-dev
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl

# Copy application files
COPY . /var/www/html
COPY --from=vendor /app/vendor /var/www/html/vendor

EXPOSE 80
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=80"]
