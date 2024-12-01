#!/bin/bash

if ! command -v docker &> /dev/null; then
  echo "Docker not found. Installing..."
  curl -sSL https://get.docker.com/ | CHANNEL=stable bash
fi

if ! command -v rclone &> /dev/null; then
  echo "rclone not found. Installing..."
  curl https://rclone.org/install.sh | sudo bash
fi

if [ -f "./rclone_config.toml" ]; then
  echo "rclone_config.toml found. Parsing remote name..."
  # Extract the first remote name from rclone_config.toml
  remote_name=$(awk -F '[][]' '/^\[/{print $2}' ./rclone_config.toml | head -n 1)
else
  echo "rclone_config.toml not found. Setting up rclone..."
  rclone config
  read -p "Enter the name of your rclone remote: " remote_name
fi

if [ ! -d "./mcreserve_data" ]; then
  mkdir -p ./mcreserve_data
  echo "Importing data from rclone remote..."
  rclone sync --exclude "{libraries/**,.cache/**,.fabric/**}" --config ./rclone_config.toml -P ./mcreserve_data "${remote_name}:mcreserve"
fi

chmod +x stop.sh
chmod +x sync.sh
docker compose up -d