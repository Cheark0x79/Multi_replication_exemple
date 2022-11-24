FROM mariadb:latest
ENV MARIADB_USER=boite
ENV MARIADB_ROOT_PASSWORD=boite
ENV MARIADB_PASSWORD=boite
ENV MARIADB_DATABASE=wordpress

COPY ./my.cnf /my.cnf

RUN cat /my.cnf >> /etc/mysql/my.cnf
