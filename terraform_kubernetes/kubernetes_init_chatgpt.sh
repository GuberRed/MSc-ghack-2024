#!/bin/bash

# Define the array of team names
teams=("team1" "team2" "team3")

# Loop through each team and create namespace, role, and role binding
for team in "${teams[@]}"
do
    # Create namespace
    kubectl create namespace $team

    # Create role
    cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: ${team}-role
  namespace: $team
rules:
- apiGroups: [""]
  resources: ["*"]
  verbs: ["*"]
EOF

    # Create role binding
    cat <<EOF | kubectl apply -f -
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: ${team}-binding
  namespace: $team
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: ${team}-role
subjects:
- kind: User
  name: ${team}-sa@prj-${team}.iam.gserviceaccount.com
EOF

done
