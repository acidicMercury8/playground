kubectl create namespace test-namespace
helm create test-chart
helm install my-helm-release test-chart -n test-namespace -f test-chart/values.yaml
helm uninstall my-helm-release
kubectl create namespace dev-namespace
helm install my-dev-release test-chart -n dev-namespace -f test-chart/dev.yaml
helm package test-chart

helm repo add grafana https://grafana.github.io/helm-charts
helm install grafana  stable/grafana
kubectl get pods -w
kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=grafana,app.kubernetes.io/instance=grafana" -o jsonpath="{.items[0].metadata.name}")
kubectl --namespace default port-forward $POD_NAME 3000
