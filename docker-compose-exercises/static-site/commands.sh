docker run --rm -p 8080:80 --name nginx-compose nginx
curl 127.0.0.1:8080
docker run --rm -p 8080:80 -v ${pwd}/static-site:/usr/share/nginx/html --name nginx-compose nginx
curl localhost:8080/index.html
docker compose up

docker ps
docker exec -it static-site-nginx-1 cat /etc/nginx/nginx.conf
docker cp static-site-nginx-1:/etc/nginx/nginx.conf nginx.conf

docker build -t custom-nginx:0.1 .
docker compose -f docker-compose-custom.yml up
