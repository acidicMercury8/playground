kubectl create -f pod-mysql.yaml
kubectl create -f pod-www.yaml
cat pod-mysql.yaml pod-www.yaml

kubectl get pods
kubectl describe pod mysql
