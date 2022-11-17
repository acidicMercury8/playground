kubectl apply -f env-configmap.yaml
kubectl create cm test-config -n data-storage --from-file=root-ca.pem
