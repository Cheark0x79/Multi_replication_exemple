FROM mariadb:latest
ENV MARIADB_USER=boite
ENV MARIADB_ROOT_PASSWORD=boite
ENV MARIADB_PASSWORD=boite
ENV MARIADB_DATABASE=wordpress

RUN apt update && apt install chrony -y

RUN apt install curl software-properties-common -y

RUN sed -i 's|bind-address            = 127.0.0.1|bind-address            = 0.0.0.0|' /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./my.cnf /my.cnf

RUN cat /my.cnf >> /etc/mysql/my.cnf
