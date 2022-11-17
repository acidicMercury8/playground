kubectl apply -f nodeport.yaml
cat nodeport.yaml

kubectl get pods
kubectl get pods -w

curl 172.17.0.11:30080
curl 172.17.0.11:30080
