#docker build -t multiplayer-game .
#docker run -p 5000:5000 multiplayer-game

#!/bin/bash

stop_containers() {
  docker stop $(docker ps -aq)
}

clean_images() {
  docker image prune -af
}

clean_volumes() {
  docker volume prune -f
}

start_docker_compose() {
  docker-compose up -d
}

restart_environment() {
  stop_containers
  clean_images
  clean_volumes
  start_docker_compose
}

# Usage
restart_environment

