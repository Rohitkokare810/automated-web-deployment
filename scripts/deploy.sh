#!/bin/bash

PROJECT_DIR="/home/ec2-user/automated-web-deployment"
WEB_DIR="/var/www/html"

echo "Starting deployment..."

cd "$PROJECT_DIR" || exit 1

echo "Pulling latest code from GitHub..."
git pull origin main || exit 1

echo "Copying website files..."
sudo cp -r "$PROJECT_DIR/website/"* "$WEB_DIR/"

echo "Setting permissions..."
sudo chown -R apache:apache "$WEB_DIR"

echo "Restarting Apache..."
sudo systemctl restart httpd

echo "Deployment completed successfully."
