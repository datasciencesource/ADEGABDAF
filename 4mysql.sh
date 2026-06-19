#!/bin/bash

MYSQL_ROOT_PASSWORD="Admin1111"
MYSQL_DB="dbtest"
MYSQL_USER="usertest"
MYSQL_PASSWORD="Admin1111"

apt update -y
apt install mysql-server expect -y

systemctl start mysql
systemctl enable mysql

expect <<'EOF'
set timeout 60

spawn mysql_secure_installation

expect {
    -re "Press y\\|Y for Yes.*No.*:" {
        send "n\r"
        exp_continue
    }
    -re "Remove anonymous users.*:" {
        send "y\r"
        exp_continue
    }
    -re "Disallow root login remotely.*:" {
        send "y\r"
        exp_continue
    }
    -re "Remove test database.*:" {
        send "y\r"
        exp_continue
    }
    -re "Reload privilege tables now.*:" {
        send "y\r"
        exp_continue
    }
    eof
}
EOF

mysql <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '${MYSQL_ROOT_PASSWORD}';

CREATE DATABASE IF NOT EXISTS ${MYSQL_DB};

CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';

GRANT ALL PRIVILEGES ON ${MYSQL_DB}.* TO '${MYSQL_USER}'@'localhost';

FLUSH PRIVILEGES;

USE ${MYSQL_DB};

CREATE TABLE IF NOT EXISTS table_stock (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    purchasing_price FLOAT,
    quantity DOUBLE,
    stock_date DATETIME
);
EOF

echo "MySQL installed, secured, root password set, and dbtest.table_stock created."
echo "Root login: root / ${MYSQL_ROOT_PASSWORD}"
echo "User login: ${MYSQL_USER} / ${MYSQL_PASSWORD}"
