kubectl apply -f cloudprovider.yaml
cat loadbalancer.yaml

kubectl get pods -n kube-system
kubectl get svc

export LoadBalancerIP=$(kubectl get services/webapp1-loadbalancer-svc -o go-template='{{(index .status.loadBalancer.ingress 0).ip}}')
echo LoadBalancerIP=$LoadBalancerIP
curl $LoadBalancerIP
curl $LoadBalancerIP
curl $LoadBalancerIP
curl $LoadBalancerIP
curl $LoadBalancerIP
