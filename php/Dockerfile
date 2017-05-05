FROM php:7.1.3-fpm

RUN apt-get update -y && apt-get upgrade -y && DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes \
  git \
  libxml2-dev \
  libldb-dev \
  libldap2-dev \
  libmcrypt-dev \
  libpcre++-dev \
  libfreetype6-dev \
  libpng-dev

# Configure some of the PHP extensions before we install them, then install.
RUN docker-php-ext-configure ldap \
  --with-libdir=lib/x86_64-linux-gnu && \
docker-php-ext-configure gd \
  --with-freetype-dir=/usr/include/ && \
docker-php-ext-install \
  ldap \
  calendar \
  pdo_mysql \
  mysqli \
  gd \
  soap \
  mcrypt

# Install Tideways for profiling
RUN cd /usr/src && \
  git clone https://github.com/tideways/php-profiler-extension.git && \
  cd php-profiler-extension && \
  phpize && \
  ./configure && \
  make && \
  make install && \
  docker-php-ext-enable tideways

# Install XDebug and the oauth extension for Authentickated.
RUN pecl channel-update pecl.php.net && \
  pecl install xdebug && \
  pecl install oauth && \
  docker-php-ext-enable xdebug && \
  docker-php-ext-enable oauth

# Copy our xdebug config to the additional ini files dir.
COPY xdebug.ini /usr/local/etc/php/conf.d/custom-xdebug-config.ini

RUN echo "request_terminate_timeout = 0" >> /usr/local/etc/php-fpm.d/www.conf
