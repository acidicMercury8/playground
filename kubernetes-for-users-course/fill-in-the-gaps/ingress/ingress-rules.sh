cat ingress-rules.yaml
kubectl create -f ingress-rules.yaml
kubectl get ing
kubectl describe ingress webapp-ingress
curl -H "Host: my.kubernetes.example" 172.17.0.9/webapp1
