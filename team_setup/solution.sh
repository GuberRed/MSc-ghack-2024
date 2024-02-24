kubectl get pods -n $team_namespace
kubectl describe deployment gubgub-frontend -n $team_namespace
kubectl get deployment gubgub-frontend -n $team_namespace -o yaml > user_deployment.yaml
kubectl delete deployment gubgub-frontend -n $team_namespace
#change password in user_depoloyment
kubectl apply -f user_deployment.yaml
kubectl delete pod gubgub-frontend-5d97c6fd54-bs276 -n $team_namespace
kubectl logs gubgub-frontend-5d97c6fd54-w96z8 -n $team_namespace
kubectl describe svc app-service -n $team_namespace | grep "LoadBalancer Ingress"
#DODAJ ROLE DLA CLUSTER SA DO REGISTRY

#LoadBalancer Ingress:     35.187.98.0