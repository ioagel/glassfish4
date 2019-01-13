# HOWTO

Glassfish runs by default as *user* **glassfish** with *uid* **10001**.
You can override it with the *env* vars **USER_NAME** and **USER_ID**.

    docker run -d --name gf -p 8080:8080 floulab/glassfish4:tag
    docker run -d --name gf -p 8080:8080 -e USER_NAME=test -e USER_ID=1100 floulab/glassfish4:tag
