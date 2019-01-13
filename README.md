# HOWTO

Glassfish runs by default as *user* **glassfish** with *uid* **10001**.
You can override it with the *env* vars **USERNAME** and **UID**.

    docker run -d --name gf -p 8080:8080 floulab/glassfish4
    docker run -d --name gf -p 8080:8080 -e USERNAME=test -e UID=1100 floulab/glassfish4
