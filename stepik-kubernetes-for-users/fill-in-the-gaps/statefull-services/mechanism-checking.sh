docker exec -it nfs-server bash -c "echo 'Hello World' > /exports/data-0001/index.html"
ip=$(kubectl get pod www -o yaml | grep podIP | awk '{split($0,a,":"); print a[2]}'); echo $ip
curl $ip

docker exec -it nfs-server bash -c "echo 'Hello NFS World' > /exports/data-0001/index.html"
curl $ip

kubectl delete pod www
kubectl create -f pod-www2.yaml
ip=$(kubectl get pod www2 -o yaml | grep podIP | awk '{split($0,a,":"); print a[2]}'); curl $ip
