#!/bin/bash

cd /opt || exit

# Download MySQL Connector/J
wget -O mysql-connector-j-8.4.0.tar.gz https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-j-8.4.0.tar.gz

# Extract
tar -xzf mysql-connector-j-8.4.0.tar.gz

# Create NiFi JDBC driver directory
mkdir -p /opt/nifi/mysql-connector-j-8.4.0

# Copy JAR file
cp mysql-connector-j-8.4.0/mysql-connector-j-8.4.0.jar /opt/nifi/mysql-connector-j-8.4.0/

# Set permissions
chmod 644 /opt/nifi/mysql-connector-j-8.4.0/mysql-connector-j-8.4.0.jar

# Verify
ls -lh /opt/nifi/mysql-connector-j-8.4.0/mysql-connector-j-8.4.0.jar
