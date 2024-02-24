FROM mysql:latest

ENV MYSQL_ROOT_PASSWORD=haselko

ENV MYSQL_DATABASE=game_db

COPY init/init_db.sql /docker-entrypoint-initdb.d/

EXPOSE 3306