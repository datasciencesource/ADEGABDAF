#!/bin/bash

PHPMYADMIN_PASSWORD="Admin1111"

apt update -y

# Pre-answer phpMyAdmin installation questions
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password ${PHPMYADMIN_PASSWORD}" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password ${PHPMYADMIN_PASSWORD}" | debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password ${PHPMYADMIN_PASSWORD}" | debconf-set-selections

DEBIAN_FRONTEND=noninteractive apt install apache2 php libapache2-mod-php php-mysql phpmyadmin -y

systemctl restart apache2

echo "phpMyAdmin installed successfully."
echo "Open: http://localhost/phpmyadmin"
