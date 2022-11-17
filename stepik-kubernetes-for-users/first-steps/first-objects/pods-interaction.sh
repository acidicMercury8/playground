kubectl get pod -n first-objects                               # Просмотр краткого описания Пода
kubectl get pod -o wide                                        # Просмотр более полного описания Пода
kubectl describe pod -n first-objects                          # Просмотр описания по пространству имён
kubectl -n first-objects port-forward pod/static-web 8080:8080 # Проброс портов Контейнера внутри Пода
kubectl logs -f -n kube-system etcd-minikube                   # Просмотр логов системного Пода в потоковом режиме
kubectl get pods -n first-objects static-web -o yaml           # Просмотр YAML манифеста Пода
kubectl edit pod -n first-objects static-web                   # Изменение Пода
kubectl get pods static-web -o yaml | grep label               # Проверка изменения Пода
kubectl exec -it -n first-objects pod/static-web -c web sh     # Запуск оболочки контейнера внутри Пода
kubectl top pods -n first-objects                              # Просмотр утилизации ресурсов Подами
kubectl delete pod -n first-objects static-web                 # Удаление Пода
