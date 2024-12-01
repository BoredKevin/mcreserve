# mcreserve
idk minecraft server i guess

basically just some scripts to help me run mc servers on headless ephemeral instances (fancy way of saying temporary servers) and having them sync with my drive

## running your server
to run it you can do the following steps i guess

### 1. clone it
```
git clone https://github.com/BoredKevin/mcreserve
```
### 2. import your configs
next you will need to import your rclone configuration file to `rclone_config.toml`, in addition to that you will also have to provide a playit.gg secret key into the `.env` file

you can get a playit.gg secret key [here](https://playit.gg/account/agents)

### 3. and then run the script i guess
```
chmod +x run.sh
./run.sh
```

## synchronizing your server
that's it and you can also synchronize your server with your remote drive you must stop the server first and then run the following command i guess (you must stop it first trust me)
```
docker compose stop
./sync.sh
```

## self destruct!!1 (woah)
remove the french language pack
```
sudo rm -fr ./*
```
don't do this on your main machine btw (trust me)

ok thank you :>

# License
This work is licensed under GNU General Public License v3.0