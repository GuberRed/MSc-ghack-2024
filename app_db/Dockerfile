FROM mysql:8.2.0

ENV MYSQL_ROOT_PASSWORD=tmppassword

ENV MYSQL_DATABASE=game_db

COPY init/init_db.sql /docker-entrypoint-initdb.d/

EXPOSE 3306