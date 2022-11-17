kubectl rollout history deployment/goapp-deployment # Проверить историю деплоймента
kubectl rollout undo deployment/goapp-deployment    # Откатиться к предыдущей версии деплоймента
kubectl rollout restart deployment/goapp-deployment # Плавающий рестарт Подов в деплойменте
