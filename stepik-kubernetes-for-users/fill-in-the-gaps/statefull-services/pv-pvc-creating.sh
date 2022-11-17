docker run -d --net=host --privileged --name nfs-server katacoda/contained-nfs-server:centos7 /exports/data-0001 /exports/data-0002
docker ps | grep nfs
docker inspect <CONTAINER_ID>

kubectl create -f nfs-0001.yaml
kubectl create -f nfs-0002.yaml
cat nfs-0001.yaml nfs-0002.yaml

kubectl get pv

kubectl create -f pvc-mysql.yaml
kubectl create -f pvc-http.yaml
cat pvc-mysql.yaml pvc-http.yaml

kubectl get pvc
