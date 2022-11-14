docker build . -t go:v0.2
docker images
docker run -d -p 8080:8080 go:v0.2
docker ps

docker login
docker tag go:v0.2 acidicmercury8/goapp:v0.2
docker push acidicmercury8/goapp:v0.2
