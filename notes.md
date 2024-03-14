# notes

## 2024-03-14

### Steps

create and fill in `credentials.sh`:

```
export ADMIN_EMAIL=((your-email))
export ADMIN_PASSWORD=((password))
```

create CF resources and push app

```
cf create-org postfacto
cf create-space -o postfacto postfacto
cf t -s postfacto

cf create-service p.redis on-demand-cache postfacto-redis
cf create-service p.mysql db-small postfacto-db

. ./environment.sh

cf push -f manifest.yml -p postfacto-release --var "app-name=$APP_NAME" --var "session-time=$SESSION_TIME"
```

had to increase memory to 3G to get asset precompilation to finish without getting OOMkilled

```
cf scale "$APP_NAME" -m 1G

cf run-task "$APP_NAME" --command "ADMIN_EMAIL=$ADMIN_EMAIL ADMIN_PASSWORD=$ADMIN_PASSWORD rake admin:create_user"
```

logged into admin panel at `/admin` with the admin credentials

created retro:

link: https://postfacto-tas-pm.apps.dhaka.cf-app.com/retros/tas-pms

## 2023-08-18

### inspecting the MySQL DB charset and collation

```
cf ssh -N -L 63306:HOSTNAME:3306 postfacto
/opt/homebrew/opt/mysql-client/bin/mysql -u USER -h 0 -p -D service_instance_db -P 63306
```

utf8mb4 is set on all the columns and as the database and table default

research reveals that these parameters also need to be set on the mysql2 database config

first tried appending to the `DATABASE_URL` env var in a `.profile` script: works, but is hacky

added this to database.yml:

```
# mysql2-specific parameters that make emoji and other 4-byte UTF8 sequences persist
production:
  encoding: utf8mb4
  collation: utf8mb4_unicode_ci
```

repushed, and it works!

also, asset precompilation worked in only 3G of memory, so reduced manifest to that memory allocation
