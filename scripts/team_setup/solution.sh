team_namespace="piotr-case2-gcp-coe-msp-sandbox"
kubectl get pods -n $team_namespace
kubectl describe deployment gubgub-frontend -n $team_namespace
kubectl get deployment gubgub-frontend -n $team_namespace -o yaml > user_deployment.yaml
kubectl delete deployment gubgub-frontend -n $team_namespace
#change password in user_depoloyment
#OR kubectl exec -it gubgub-db /bin/bash -n $team_namespace // echo $MYSQL_ROOT_PASSWORD #this is cheat way on purpose
kubectl apply -f user_deployment.yaml
kubectl describe svc app-service -n $team_namespace | grep "LoadBalancer Ingress"
kubectl get pods -n $team_namespace
