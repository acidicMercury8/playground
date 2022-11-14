docker build . -t go:v0.2
docker images
docker run -d -p 8080:8080 go:v0.2
docker ps
