docker volume create example-volume
docker volume ls --filter="name=example-volume" --format='{{json .}}'
docker run -it --rm --name example-volume-container --mount source=example-volume,target=/storage bash
echo some-text > /storage/data-file.txt
cat /storage/data-file.txt
exit
docker run -it --rm --name second-volume-container --mount source=example-volume,target=/storage bash
cat /storage/data-file.txt
docker inspect second-volume-container --format '{{json .Mounts}}'

docker run -it --rm --name container-2 --mount source=example-volume,target=/storage bash -c "for i in \$(seq 1 1 100000); do echo \$HOSTNAME \$i >> /storage/\$HOSTNAME.txt; done"
docker run -it --rm --name container-1 --mount source=example-volume,target=/storage bash -c "for i in \$(seq 1 1 100000); do echo \$HOSTNAME \$i >> /storage/\$HOSTNAME.txt; done"
docker run -it --rm --name container-1 --mount source=example-volume,target=/storage bash
ls /storage

docker run -it --rm --name read-only-volume-container --mount source=example-volume,target=/storage,readonly bash
cat /storage/data-file.txt
touch /storage/test.txt

docker volume inspect example-volume

docker network ls
docker run --rm -p 8080:80 --name nginx-compose nginx
docker inspect --format '{{json .NetworkSettings.Networks}}'
NETWORK_ID=$(docker inspect --format '{{json .NetworkSettings.Networks.bridge.NetworkID}}' nginx-compose | sed 's/"//g')
docker network ls --filter ID=$NETWORK_ID

docker run --rm --network host --name host-nginx nginx
docker run -it --network host --rm --name nginx-wget bash
wget -0- localhost:80
