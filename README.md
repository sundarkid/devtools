# sup-docker-files

Note: For running the environment locally, please install docker on your machine.

The docker-compose file has the containers specs required for running a complete environment in docker.

The compose file will be updated with latest details as the project scope expands.


## To run a local environment
Steps:

1. [Install docker desktop](https://www.docker.com/products/docker-desktop)
2. Run the environment,
    ```bash
    # to start running containers on terminal
    ./setup-local.sh start 
    # to start running containers in background
    ./setup-local.sh bg 
    # to stop running containers in background
    ./setup-local.sh stop 
    # Stop the containers and clean up on docker
    ./setup-local.sh cleanup
    ```