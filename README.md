# DAWA(Denmarks Adresses Web Api)

This repository contains a docker implementation of the [DAWA](https://dawa.aws.dk/) reference [client](https://dawa.aws.dk/dok/guide/replikeringsklient#introduktion), plus a *client ready* postgres database.

DAWA provides data and functionality around addresses in Denmark. Basically an API. The client, which is dockerized in this repository, is a node application which, when given a postgres database with postgis configured, will replicate the data to a the local postgres database.

## Pre-Requisites

* Linux: Almost any newer distribution of Linux will do. It has been verified on CentOS-7. It will even run on Windows if you install [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10) and [Docker for Windows](https://docs.docker.com/docker-for-windows/install/). But this is only recommended for development purposes.  
* [Docker](https://docs.docker.com/): Version 1.13.1 and forward. Probably older versions of docker as well. 
* [Docker Compose](https://docs.docker.com/compose/): Version 1.18.0 and forward. 

## Replication Container
A [wrapper script](./replication-client/wrapper.sh) is the **entry-point** for the replication-client container. 

* On container start the wrapper executes a replication.
* Afterwards it waits for a specified period of time and executes another replication.

**NOTE:** The replication-client expects a configuration file to be specified when executing a replication run. At present, these files are **baked into** the image. If needed we can mount them from the docker host in the future.

**NOTE:** Presently the period between replications defaults to `3600` seconds in the wrapper.sh script. This can be overridden by setting the value of `REPLICATOR_SYNC_PERIOD` in the `.env` file located in the root of this repository or exporting the variable to the environment. It is **recommended** to modify the .env file as this will survive reboots of the host!   

## Database Container
There are two scripts which are executed on container start.

* `01-enable-postgis.sh` - Enables postgis extension on the defined database.
* `02-create-schema.sql` - Generates the defined schema/tables for the replication.

The database data is `persisted` in a docker volume on the **host running the container**. As long as the docker volume is **not** deleted its contents will survive the stopping and even deletion of the container.

## Building
To build the image run `docker-compose build` from the root of the repository.

This will build both the postgres image and the replication-client image and tag it with the version defined in the docker-compose file.

**NOTE:** If you have cloned the repository from powershell, windows git or a windows client. **Then you will probably have issues with line endings!** Run dos2unix on **all** files OR install bash for windows and re-clone the repository **before** building.

## Preparing The Host
Make sure that, git, docker and docker-compose are installed on the host and the user which you login with has **sudo** rights.

The containers should run under a dedicate system user `dawa-replicator`. 

* SSH into the host: `ssh <USERNAME HERE>@<HOSTNAME HERE>`.
* Switch to root: `sudo su`.
* Create system user: `useradd --system dawa-replicator`.
* Switch user to system user: `su dawa-replicator`.
* Clone this repository.

## Deploying
You **cannot** login as the dawa-replicator user as this is not allowed with a system user. You **must** login in to the machine with a user that has **sudo** rights and then switch to the system user.

* Login to a Linux box with a Bash shell through ssh.
* Switch user: `sudo su dawa-replicator`.
* Change directory to where you cloned the repository.
* Edit the .env file and **change** the default `password`. Possibly change the `REPLICATOR_SYNC_PERIOD` from the default of 3600 seconds if something besides once an hour is wanted.
* Execute `docker-compose up -d` from the root of the repository. If the containers do not yet exist on the host they will be built before being started.
* Check that the containers are running. The command `docker ps` should show two containers running with the `docker ps` command. You should see a container for the replication client and the postgres database.

* Check the logs of the containers with docker logs and inspect it for problems. Example: `docker logs <CONTAINER NAME HERE>`.

To pull it down you can use the following commands from the root of the repository.

* `docker-compose stop` - Stops but does not remove the containers. Logs will be persisted.
* `docker-compose down` - Stops and removes the containers. Logs will **not** be persisted. This will **not delete** the postgres containers docker volume. So a new container will have the latest data from previous container.

A `restart policy` of `unless-stopped` is set in the docker-compose file. This means the container **will be restarted** if the host is rebooted, the container exits with a failure or the docker daemon is restarted. If the containers are stopped with `docker-compose stop` OR `docker-compose down` the container will **not** be restarted under the above stated conditions.

### Changing Synchronization Wait Period For Running Containers

If you wish to change the `REPLICATOR_SYNC_PERIOD` after the first deploy then you need to get the replication-client container updated. 

For example, if you would like continuous replication.

1. Edit the .env file to `REPLICATOR_SYNC_PERIOD=1` OR export the variable while in the shell with `export REPLICATOR_SYNC_PERIOD=1`. Again best to update the `.env` file.
2. Run `docker-compose up -d` again. You should see the replication-client container being **recreated**. 

```
dawa$ docker-compose up -d
dawa_postgres_1 is up-to-date
Recreating dawa_replication-client_1 ... done      <--------
``` 

## Things To Know
The postgres data is persisted in a docker volume. This volume is automatically created on first deploy with docker-compose. Run `docker volume ls` to see the volume. 

If you delete the volume it will be recreated on deploy. This will cause a **full** replication, which can take **quite** a while.

## Todo's
* We should have some indexes ion the Db. Add script 03-create-indexes.sql and place it in postgres/init/ directory.