FROM openjdk:8-slim-buster

MAINTAINER  Ioannis Angelakopoulos<ioagel@gmail.com>

ENV \
  GF_REL=4.1.2-web \
  MJDBC=8.0.18 \
  PATH="${PATH}:/glassfish4/bin"

RUN echo "deb http://deb.debian.org/debian buster contrib" > /etc/apt/sources.list.d/contrib.list
RUN apt-get update && apt-get install -y --no-install-recommends gnupg dirmngr wget unzip ttf-mscorefonts-installer && rm -rf /var/lib/apt/lists/*

RUN set -x && \
  cp -a /usr/share/fonts/truetype/msttcorefonts/* /usr/share/fonts/truetype && \
  wget http://download.oracle.com/glassfish/4.1.2/release/glassfish-${GF_REL}.zip && \
  wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MJDBC}.zip && \
  unzip glassfish-${GF_REL}.zip && \
  unzip mysql-connector-java-${MJDBC}.zip && \
  mv mysql-connector-java-${MJDBC}/mysql-connector-java-${MJDBC}.jar /glassfish4/glassfish/domains/domain1/lib/ && \
  apt-get purge -y --auto-remove wget unzip ttf-mscorefonts-installer && \
  rm -rf /usr/share/fonts/truetype/msttcorefonts /usr/share/fonts/X11 *.zip mysql*

COPY        docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT  ["docker-entrypoint.sh"]
WORKDIR     /glassfish4

EXPOSE      8080 4848 8181
# verbose causes the process to remain in the foreground so that docker can track it
CMD         ["asadmin", "start-domain", "-v"]
