FROM openjdk:8-alpine

MAINTAINER  Ioannis Angelakopoulos<ioagel@gmail.com>

ENV \
  GF_REL=4.1.2-web \
  MJDBC=5.1.47 \
  USERNAME=glassfish \
  UID=10001 \
  PATH="/glassfish4/bin:${PATH}"

RUN \
  wget http://download.oracle.com/glassfish/4.1.2/release/glassfish-${GF_REL}.zip && \
  wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MJDBC}.zip && \
  unzip glassfish-${GF_REL}.zip && \
  unzip mysql-connector-java-${MJDBC}.zip && \
  mv mysql-connector-java-${MJDBC}/mysql-connector-java-${MJDBC}-bin.jar /glassfish4/glassfish/domains/domain1/lib/ && \
  rm -rf *.zip mysql* && \
  apk --no-cache add msttcorefonts-installer su-exec && \
  update-ms-fonts && \
  mv /usr/share/fonts/truetype /usr/share/fonts/tt && \
  ln -sf /usr/share/fonts/tt/msttcorefonts /usr/share/fonts/truetype

COPY        docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT  ["docker-entrypoint.sh"]
WORKDIR     /glassfish4

EXPOSE      8080 4848 8181
# verbose causes the process to remain in the foreground so that docker can track it
CMD         ["asadmin", "start-domain", "-v"]
