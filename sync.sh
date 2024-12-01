if docker ps | grep -q "itzg/minecraft-server"; then
  echo "WARNING: The Minecraft server container is currently running."
  echo "Syncing the data while the server is running may cause issues or data corruption."
  echo "Proceeding in 10 seconds..."
  sleep 10
fi

if [ -f "./rclone_config.toml" ]; then
  echo "rclone_config.toml found. Parsing remote name..."
  # Extract the first remote name from rclone_config.toml
  remote_name=$(awk -F '[][]' '/^\[/{print $2}' ./rclone_config.toml | head -n 1)
  echo "Synchronizing data with remote.."
  rclone sync --exclude "{libraries/**,.cache/**,.fabric/**}" --config ./rclone_config.toml -P ./mcreserve_data "${remote_name}:mcreserve"
else
  echo "rclone_config.toml not found. Setting up rclone..."
  rclone config
  read -p "Enter the name of your rclone remote: " remote_name
  echo "Configuration done, run this script again to synchronize with remote"
fi
