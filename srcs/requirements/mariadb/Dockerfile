FROM debian:bullseye

EXPOSE 3306

RUN apt update
RUN apt install -y mariadb-server

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/entry.sh /usr/local/bin/

CMD ["bash", "entry.sh"]
CMD ["tail","-f"]
