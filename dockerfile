# Usar la última versión de PHP (no especificada)
FROM php:latest

# Instalar dependencias sin control
RUN apt-get update && apt-get install -y \
    curl \
    git \
    vim \
    nano \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

# Exponer todos los puertos (sin control de acceso)
EXPOSE 80 443

# Copiar archivos sensibles (como .env y credenciales) al contenedor
COPY .env /var/www/html/.env

# Copiar el código de la aplicación (sin ignorar archivos innecesarios)
COPY . /var/www/html/

# Establecer permisos incorrectos para los archivos copiados
RUN chown -R www-data:www-data /var/www/html

# Ejecutar PHP como root (mala práctica)
USER root

# Habilitar el puerto 80 para el servidor PHP (y dejarlo accesible por cualquier IP)
CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]
