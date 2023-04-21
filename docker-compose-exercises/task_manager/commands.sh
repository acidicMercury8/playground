go mod init task_manager
curl https://raw.githubusercontent.com/gin-gonic/examples/master/basic/main.go > main.go
go get github.com/gin-gonic/gin
go build
go run main.go
curl http://localhost:8080/user/John

curl --location --request POST 'localhost:8080/task/' \
    --header 'Content-Type: application/json' \
    --data-raw '{
        "id": "8b171ce0-6f7b-4c22-aa6f-8b110c19f83a",
        "name": "A task",
        "description": "A task that need to be executed at the timestamp specified",
        "timestamp": 1645275972000
    }'
curl --location --request GET 'localhost:8080/task'
curl --location --request GET 'localhost:8080/task/8b171ce0-6f7b-4c22-aa6f-8b110c19f83a'

docker compose up
docker ps --format "{{.Names}}"
docker exec -it task_manager-redis-1 bash
ls
ls /usr/local/bin
redis-cli
ZADD tasks 1645275972000 "8b171ce0-6f7b-4c22-aa6f-8b110c19f83a"
ZRANGE tasks 0 -1 WITHSCORES
docker run --rm -it --entrypoint bash redis -c 'redis-cli -h host.docker.internal -p 6379'
ZRANGE tasks 0 -1 WITHSCORES
HMSET task:8b171ce0-6f7b-4c22-aa6f-8b110c19f83a Id 8b171ce0-6f7b-4c22-aa6f-8b110c19f83a Name "A task" Description "A task that need to be executed at the timestamp specified" Timestamp 1645275972000
HGETALL task:8b171ce0-6f7b-4c22-aa6f-8b110c19f83a

go get github.com/go-redis/redis/v8
go run main.go

docker build . -t task-manager:0.1
docker run --rm -p 8080:8080 --env REDIS_HOST=host.docker.internal:6379 task-manager:0.1
docker network ls
docker run --rm -p 8080:8080 --env REDIS_HOST=redis:6379 --network=task_manager_default task-manager:0.1
docker compose up --force-recreate

docker compose build
docker compose up
docker ps
docker ps
docker ps

docker images --filter "ru.acidicmercury8.compose.app=task-manager"
docker ps --filter "ru.acidicmercury8.compose.app=task-manager"
