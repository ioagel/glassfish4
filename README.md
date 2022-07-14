# README

Glassfish 4 container with MySQL jdbc driver and Microsoft truetype fonts


    docker run -d --name gf -p 8080:8080 -v /my/autodeploy/dir/app.war:/glassfish4/glassfish/domains/domain1/autodeploy/app.war floulab/glassfish4
