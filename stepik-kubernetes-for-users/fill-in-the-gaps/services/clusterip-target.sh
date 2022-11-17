kubectl apply -f clusterip-target.yaml
cat clusterip-target.yaml

kubectl get svc
kubectl describe svc/webapp1-clusterip-targetport-svc

export CLUSTER_IP=$(kubectl get services/webapp1-clusterip-targetport-svc -o go-template='{{(index .spec.clusterIP)}}')
echo CLUSTER_IP=$CLUSTER_IP
curl $CLUSTER_IP:8080
curl $CLUSTER_IP:8080
curl $CLUSTER_IP:8080
curl $CLUSTER_IP:8080
curl $CLUSTER_IP:8080
