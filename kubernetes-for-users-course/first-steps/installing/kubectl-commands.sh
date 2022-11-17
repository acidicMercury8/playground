# Смена кластеров
kubectl config get-contexts                # Показать список контекстов
kubectl config current-context             # Показать текущий контекст (current-context)
kubectl config use-context my-cluster-name # Установить my-cluster-name как контекст по умолчанию

# Создание объектов
kubectl apply -f ./my-manifest.yaml           # Создать объект из файла
kubectl create deployment nginx --image=nginx # Запустить один экземпляр nginx

# Просмотр информации
kubectl get pods -o wide     # Вывести все поды и показать, на каких они нодах
kubectl describe pods my-pod # Просмотреть информацию о поде такую как время старта, количество и причины рестартов, QoS-класс и прочее
kubectl logs -f my-pod       # Просмотр логов в режиме реального времени
kubectl top pods             # Вывести информацию об утилизации ресурсов подами

# Изменение объектов
kubectl edit pod my-pod # Изменение .yaml манифеста пода

# Удаление объектов
kubectl delete pod my-pod # Удаление пода

# Погружение в командную оболочку Пода (проваливаемся вовнутрь)
kubectl exec -it -n namespace-name podname sh # На конце выбираем оболочку, если нет sh, ставим bash

# Копируем файл в под
kubectl cp {{namespace}}/{{podname}}:path/to/directory /local/path # Копирование файла из Пода
kubectl cp /local/path namespace/podname:path/to/directory         # Копирования файла в Под

# Проброс портов
kubectl port-forward pods/mongo-75f59d57f4-4nd6q 28015:27017 # Проброс порта Пода
kubectl port-forward mongo-75f59d57f4-4nd6q 28015:27017      # Проброс порта Сервиса
