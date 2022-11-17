kubectl get deployments -n controllers                                # Просмотр Деплойментов
kubectl describe deployment -n controllers goapp-deployment           # Просмотр описания Деплоймента
kubectl scale deployment -n controllers goapp-deployment --replicas=5 # Изменение количества реплик Подов
kubectl get pods -n controllers                                       # Просмотр Подов после изменения количества реплик
kubectl delete -f deployment.yaml                                     # Удаление Деплоймента
kubectl delete deployment -n controllers goapp-deployment             # Другой способ удаления Деплоймента
