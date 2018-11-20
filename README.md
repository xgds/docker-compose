# XGDS & Docker Compose

## Simple: using a pre-built environment

```
git clone https://github.com/xgds/docker-compose.git xgds-docker-compose
cd xgds-docker-compose
docker-compose build
docker-compose up
```

## Advanced: developing locally

```
git clone https://github.com/xgds/docker-compose.git xgds-docker-compose
cd xgds-docker-compose
```

Use your favourite editor to uncomment two lines in the `docker-compose.yml` file.

```
./local-repo.sh
docker-compose build
```

Point your favourite editor to the repository that was cloned into `./xgds_subsea`.

```
docker-compose up --detach
docker exec -it <name of docker image_xgds_bla> bash
    cd /root/xgds_subsea
    ./manage.py prepnpm
    ./manage.py createsuperuser
    ./manage.py prepmigrations
    ./manage.py migrate
    ./manage.py prepfixtures
    ./manage.py prep
    apachectl restart
    exit
```
