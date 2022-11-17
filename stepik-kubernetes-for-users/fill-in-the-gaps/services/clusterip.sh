kubectl apply -f clusterip.yaml
cat clusterip.yaml

kubectl get deployments
kubectl get pods
kubectl get svc | grep webapp

kubectl get pods -w

kubectl describe svc/webapp1-clusterip-svc

export CLUSTER_IP=$(kubectl get services/webapp1-clusterip-svc -o go-template='{{(index .spec.clusterIP)}}')
echo CLUSTER_IP=$CLUSTER_IP
curl $CLUSTER_IP:80
curl $CLUSTER_IP:80
curl $CLUSTER_IP:80
curl $CLUSTER_IP:80
curl $CLUSTER_IP:80
