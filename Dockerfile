FROM openjdk:8-alpine

LABEL org.opencontainers.image.authors="Ioannis Angelakopoulos<ioagel@gmail.com>"

ENV MJDBC=5.1.49 \
    USER_ID=10001 \
    PATH="/glassfish4/bin:${PATH}"

COPY ./entrypoint.sh /glassfish4/bin/entrypoint.sh

RUN \
  wget http://download.oracle.com/glassfish/4.1.2/release/glassfish-4.1.2-web.zip && \
  wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MJDBC}.zip && \
  unzip glassfish-4.1.2-web.zip && \
  unzip mysql-connector-java-${MJDBC}.zip && \
  mv mysql-connector-java-${MJDBC}/mysql-connector-java-${MJDBC}-bin.jar /glassfish4/glassfish/domains/domain1/lib/ && \
  rm -rf *.zip mysql* && \
  apk --no-cache add msttcorefonts-installer fontconfig && \
  update-ms-fonts && \
  mv /usr/share/fonts/truetype /usr/share/fonts/tt && \
  ln -sf /usr/share/fonts/tt/msttcorefonts /usr/share/fonts/truetype && \
  fc-cache -f && \
  adduser -h /glassfish4 -s /sbin/nologin -u ${USER_ID} -D glassfish && \
  chmod 755 /glassfish4/bin/entrypoint.sh && \
  chown -R glassfish:glassfish /glassfish4

WORKDIR     /glassfish4
USER        glassfish

EXPOSE      8080 4848 8181

ENTRYPOINT [ "entrypoint.sh" ]
# verbose causes the process to remain in the foreground so that docker can track it
CMD         ["asadmin", "start-domain", "-v"]
