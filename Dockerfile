FROM openjdk:8-slim

MAINTAINER  Ioannis Angelakopoulos<ioagel@gmail.com>

ENV \
  GF_REL=4.1.2-web \
  MJDBC=5.1.47 \
  USER_NAME=glassfish \
  USER_ID=10001 \
  PATH="${PATH}:/glassfish4/bin" \
  GOSU_VERSION=1.11

RUN echo "deb http://deb.debian.org/debian stretch contrib" > /etc/apt/sources.list.d/contrib.list

# Stolen from mysql image ;-)
# add gosu for easy step-down from root
RUN set -x && \
  apt-get update && apt-get install -y --no-install-recommends gnupg dirmngr ca-certificates wget unzip ttf-mscorefonts-installer && rm -rf /var/lib/apt/lists/* && \
  wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" && \
  wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" && \
  export GNUPGHOME="$(mktemp -d)" && \
  gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && \
  gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu && \
  gpgconf --kill all && \
  rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc && \
  chmod +x /usr/local/bin/gosu && \
  gosu nobody true && \
  cp -a /usr/share/fonts/truetype/msttcorefonts /msttcorefonts && \
  wget http://download.oracle.com/glassfish/4.1.2/release/glassfish-${GF_REL}.zip && \
  wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MJDBC}.zip && \
  unzip glassfish-${GF_REL}.zip && \
  unzip mysql-connector-java-${MJDBC}.zip && \
  mv mysql-connector-java-${MJDBC}/mysql-connector-java-${MJDBC}-bin.jar /glassfish4/glassfish/domains/domain1/lib/ && \
  rm -rf *.zip mysql* && \
  apt-get purge -y --auto-remove ca-certificates wget unzip ttf-mscorefonts-installer && \
  mkdir -p /usr/share/fonts/truetype && mv /msttcorefonts/* /usr/share/fonts/truetype/ && rm -rf /msttcorefonts

COPY        docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT  ["docker-entrypoint.sh"]
WORKDIR     /glassfish4

EXPOSE      8080 4848 8181
# verbose causes the process to remain in the foreground so that docker can track it
CMD         ["asadmin", "start-domain", "-v"]
