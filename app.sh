#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "🔧 Updating system packages..."
sudo yum update -y

echo "📦 Installing Nginx..."
sudo amazon-linux-extras install nginx1 -y || sudo yum install nginx -y

echo "🚀 Starting Nginx..."
sudo systemctl start nginx

echo "🔒 Enabling Nginx to start on boot..."
sudo systemctl enable nginx

echo "✅ Nginx is installed and running."
