docker compose build
docker images

#docker compose create
docker compose up --no-start
docker ps -a
docker compose up --detach
docker compose up --no-build --detach
docker compose up --remove-orphans

docker compose exec task-manager ls
docker ps -a
docker compose run task-manager sh
docker ps -a

docker compose pause task-manager
docker compose unpause task-manager

docker compose ps
docker compose exec task-manager sh -c "echo test > text.txt"
docker compose stop task-manager
docker compose start task-manager
docker compose exec task-manager sh -c "cat text.txt"

docker compose restart task-manager
docker compose stop task-manager
docker compose restart task-manager

docker compose kill task-manager

docker compose ps
docker compose ps --services
docker compose ps --quiet
docker compose run task-manager sh
docker compose ps -a

docker compose up
Ctrl+D
docker compose images
docker compose ps
docker network ls
docker compose down
docker compose ps
docker network ls | grep compose-commands
docker compose down --rmi local
docker compose down --rmi all

docker compose up -d
docker compose ps
docker compose rm failed-manager
docker compose rm failed-manager --force

docker compose images
docker compose images --quiet

docker compose pull --ignore-pull-failures --parallel

docker compose build
docker compose push

docker compose up -d
docker compose logs
docker compose logs -f #--follow
docker compose logs -f --timestamps --tail="3" --no-color
docker compose top

docker compose events
docker compose stop task-manager
docker compose events

docker compose help
docker compose version

docker compose port task-manager 8080
docker compose config
docker compose config --services
docker compose config --volumes
