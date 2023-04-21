kompose convert

minikube stop && minikube delete
minikube start --network-plugin=cni --cni=calico

kubectl create deployment nginx --image=nginx
kubectl get pod

eval $(minikube docker-env)
docker compose build
kubectl apply -f redis-deployment.yaml
kubectl apply -f redis-service.yaml
kubectl apply -f redis-network-networkpolicy.yaml
kubectl apply -f event-service-deployment.yaml
kubectl apply -f location-service-deployment.yaml
kubectl apply -f location-service-service.yaml
kubectl apply -f location-network-networkpolicy.yaml
kubectl apply -f task-manager-deployment.yaml
kubectl apply -f task-manager-service.yaml
kubectl port-forward svc/task-manager 8080:8080
curl --location --request POST '127.0.0.1:8080/task/' \
    --header 'Content-Type: application/json' \
    --data-raw '{
        "id": "8b171ce0-6f7b-4c22-aa6f-8b110c19f83a",
        "name": "A task",
        "description": "A task that need to be executed at the
        timestamp specified",
        "timestamp": 1645275972000,
        "location": {
            "id": "1c2e2081-075d-443a-ac20-40bf3b320a6f",
            "name": "Liverpoll Street Station",
            "description": "Station for Tube and National Rail",
            "longitude": -0.081966,
            "latitude": 51.517336
        }
    }'

kubectl create -f - <<EOF
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: deny-all
spec:
  podSelector:
    matchLabels: {}
EOF

kubectl delete –f ./redis-network-networkpolicy.yaml
