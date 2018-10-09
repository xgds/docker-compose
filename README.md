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
docker exec -it xgdsdockercompose_xgds_1 bash
    cd /root/xgds_subsea
    ./manage.py prep
    ./manage.py prepnpm
    apachectl restart
    exit
```
