#!/bin/bash
[ -f .env ] && export $(grep -v '^#' .env | xargs)

echo "Stopping server.."
docker compose stop
if [ -f "./rclone_config.toml" ]; then
  echo "rclone_config.toml found. Parsing remote name..."
  # Extract the first remote name from rclone_config.toml
  remote_name=$(awk -F '[][]' '/^\[/{print $2}' ./rclone_config.toml | head -n 1)
  echo "Synchronizing data with remote.."
  rclone sync --exclude ${RCLONE_EXCLUDE} --config ./rclone_config.toml -P ./mcreserve_data "${remote_name}:mcreserve"
  docker compose rm
else
  echo "rclone_config.toml not found. Setting up rclone..."
  rclone config
  read -p "Enter the name of your rclone remote: " remote_name
  echo "Configuration done, run this script again to synchronize with remote"
fi