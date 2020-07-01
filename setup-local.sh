#/bin/sh
function setup_docker_run() {

echo "Setting up the directories needed for container mount points"

for i in \
jenkins \
mongo \
node-red \
dashboard \
cockroach/node_1 \
cockroach/node_2 \
cockroach/node_3
do
    echo "Checking if directory $i already exists"
    if [ ! -d $i ]; then 
    echo "Creating directory $i"
    echo
    mkdir $i
    fi
done

# Cloning the UI code
rm -rf dashboard/code/
mkdir -p dashboard/code
git clone https://github.com/coreui/coreui-free-react-admin-template.git dashboard/code

# Building the Dashboard UI container
cp dashboard.dockerfile dashboard

docker build -t dashboard:latest -f dashboard.dockerfile dashboard/

DOCKER=`which docker`

echo $DOCKER
if [ ! -f $DOCKER ]  ; then 
    echo "Docker binary not found"
    exit
fi


COMPOSE=`which docker-compose`

echo $COMPOSE
if [ ! -f $COMPOSE ]  ; then 
    echo "Docker-Compose binary not found"
    exit
fi
}

if [[ $1 == "start" ]]; then
    setup_docker_run
    if [[ $2 == "bg" ]]; then
        docker-compose up --force-recreate --detach
    else
        docker-compose up --force-recreate
    fi
elif [[ $1 == "stop" ]]; then
    docker-compose stop
elif [[ $1 == "cleanup" ]]; then
    docker-compose down
else
    echo "
The available options are,

    - start - Start the docker containers on the terminal
        options:
            bg - starts the containers in the background
    - stop - Stop the containers and clean them up



# Examples

./setup-local.sh start          # Start the containers

./setup-local.sh start bg       # Start the containers in the background

./setup-local.sh stop           # Stop the containers

./setup-local.sh cleanup        # Stop the containers and clean up on docker
"
fi
