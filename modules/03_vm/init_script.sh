#!/bin/bash
set -e

# Wait for apt lock to be released
wait_for_apt() {
  while sudo fuser /var/lib/apt/lists/lock >/dev/null 2>&1 ; do
    echo "Waiting for other apt-get instances to finish..."
    sleep 1
  done
}

wait_for_apt

# Update and install necessary packages
sudo apt-get update
sudo apt-get install -y nginx certbot python3-certbot-nginx default-mysql-client wget

# Configure Nginx
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/ssl/private/nginx-selfsigned.key \
  -out /etc/ssl/certs/nginx-selfsigned.crt \
  -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"

sudo tee /etc/nginx/sites-available/default << EOF
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name _;
    return 301 https://\$host\$request_uri;
}

server {
    listen 443 ssl default_server;
    listen [::]:443 ssl default_server;
    ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
    root /var/www/html;
    index index.html index.htm index.nginx-debian.html;
    server_name _;
    location / {
        try_files \$uri \$uri/ =404;
    }
}
EOF

sudo systemctl enable nginx
sudo systemctl restart nginx

echo "<html><body><h1>Welcome to Nginx on Azure!</h1></body></html>" | sudo tee /var/www/html/index.html

# Download DigiCert Global Root CA certificate
sudo wget https://dl.cacerts.digicert.com/DigiCertGlobalRootCA.crt.pem -O /home/azureuser/DigiCertGlobalRootCA.crt.pem
sudo chown azureuser:azureuser /home/azureuser/DigiCertGlobalRootCA.crt.pem
sudo chmod 644 /home/azureuser/DigiCertGlobalRootCA.crt.pem

# Create a MySQL configuration file with SSL settings
sudo tee /home/azureuser/.my.cnf << EOF
[client]
ssl-ca=/home/azureuser/DigiCertGlobalRootCA.crt.pem
ssl=1
EOF

# Set correct permissions for the MySQL configuration file
sudo chown azureuser:azureuser /home/azureuser/.my.cnf
sudo chmod 600 /home/azureuser/.my.cnf

echo "MySQL client installed and configured with SSL certificate."