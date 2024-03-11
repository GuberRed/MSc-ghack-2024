team_namespace="dispatcher-gcp-coe-msp-sandbox"
#DIAGNOSE
#kubectl logs <podname> -n $team_namespace
kubectl get pods -n $team_namespace
kubectl describe deployment gubgub-frontend -n $team_namespace
kubectl get deployment gubgub-frontend -n $team_namespace -o yaml > user_deployment.yaml
kubectl delete deployment gubgub-frontend -n $team_namespace
#change password in user_depoloyment REPLICA HAS TO BE 1
#OR kubectl exec -it gubgub-db /bin/bash -n $team_namespace // echo $MYSQL_ROOT_PASSWORD #this cheat is on purpose
kubectl apply -f user_deployment.yaml
kubectl describe svc app-service -n $team_namespace | grep "LoadBalancer Ingress"
kubectl get pods -n $team_namespace
