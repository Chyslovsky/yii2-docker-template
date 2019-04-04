#Application (PHP7-FPM - NGINX - MySQL)

This complete stack run with docker and [docker-compose (1.7 or higher)](https://docs.docker.com/compose/).

## Installation
1. Create a `.env` from the `.env.dist` file. Adapt it according to your symfony application

    ```bash
    cp .env.dist .env
    ```


2. Build/run containers with (with and without detached mode)

    ```bash
    $ docker-compose build
    $ docker-compose up -d
    ```

3. Update your system host file (add application)

    ```bash
    # UNIX only: get containers IP address and update host (replace IP according to your configuration)
    $ docker network inspect bridge | grep Gateway

    # unix only (on Windows, edit C:\Windows\System32\drivers\etc\hosts)
    $ sudo echo "171.17.0.1 application" >> /etc/hosts
    ```

    **Note:** For **OS X**, please take a look [here](https://docs.docker.com/docker-for-mac/networking/) and for **Windows** read [this](https://docs.docker.com/docker-for-windows/#/step-4-explore-the-application-and-run-examples) (4th step).

4. Prepare application
        Composer install & npm install

        ```bash
        $ docker-compose exec php bash
        $ composer install
        $ npm install
        $ gulp
        ```

5. Enjoy :-)

## Usage

Just run `docker-compose up -d`, then:

* Hubber app: visit [application](http://application)  

## Customize

If you want to add optionals containers like Redis, PHPMyAdmin... take a look on [doc/custom.md](doc/custom.md).

## How it works?

Have a look at the `docker-compose.yml` file, here are the `docker-compose` built images:

* `db`: This is the MySQL database container,
* `php`: This is the PHP-FPM container in which the application volume is mounted,
* `nginx`: This is the Nginx webserver container in which application volume is mounted too,

This results in the following running containers:

```bash
$ docker-compose ps
           Name                          Command               State              Ports            
--------------------------------------------------------------------------------------------------
docker_db_1            /entrypoint.sh mysqld            Up      0.0.0.0:3306->3306/tcp      
docker_nginx_1         nginx                            Up      443/tcp, 0.0.0.0:80->80/tcp
docker_php_1           php-fpm                          Up      0.0.0.0:9000->9000/tcp      
```

## Useful commands

```bash
# bash commands
$ docker-compose exec php bash

# Composer (e.g. composer update)
$ docker-compose exec php composer update

# Retrieve an IP Address (here for the nginx container)
$ docker inspect --format '{{ .NetworkSettings.Networks.dockersymfony_default.IPAddress }}' $(docker ps -f name=nginx -q)
$ docker inspect $(docker ps -f name=nginx -q) | grep IPAddress

# MySQL commands
$ docker-compose exec db mysql -uroot -p"root"

# Check CPU consumption
$ docker stats $(docker inspect -f "{{ .Name }}" $(docker ps -q))

# Delete all containers
$ docker rm $(docker ps -aq)

# Delete all images
$ docker rmi $(docker images -q)

# Check container logs
$ docker-compose logs  $(docker images -q)

```

## FAQ

* Got this error: `ERROR: Couldn't connect to Docker daemon at http+docker://localunixsocket - is it running?
If it's at a non-standard location, specify the URL with the DOCKER_HOST environment variable.` ?  
Run `chmod 777 /var/run/docker.sock`
and `docker-compose up -d` instead.


* How to config Xdebug?
Xdebug is configured out of the box!
Just config your IDE to connect port  `9001` and id key `PHPSTORM`

## Contributing

First of all, **thank you** for contributing ♥  
If you find any typo/misconfiguration/... please send me a PR or open an issue. You can also ping me on email chyslovsky@gmail.com).  
Also, while creating your Pull Request on GitHub, please write a description which gives the context and/or explains why you are creating it.
