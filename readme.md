#pre:
1. make sure there is no secrets (script/admin_setup/clean_secrets.sh)
2. make sure terraform is destroyed (terraform cloud)

#PREPARE INFRA:
1. admin - run terraform
2. admin - publish docker image (scripts/admin_setup/init_apppublish.sh) ps. you have to be in /app folder and run it

#hackatron begins
#ROLES NEEDED
-iam.serviceAccounts.getAccessToken or roles/iam.serviceAccountViewer TOTEST
1. team - service account viewer (scripts/team_setup/user_viewersa.sh)
2. team - publish sa name to cloud function (https://europe-west1-abel-ghack-infra.cloudfunctions.net/ghack-function)
3. team - impersonate as service account in terminal (scripts/team_setup/user_init)
4. team - fix deployemnt - (scripts/team_setup/solution.sh)
5. team - create an account
6. team - login
7. team - challange done
8. team - clean config (OPTIONALY) - (scripts/team_setup/clean_config.sh)

add namespace to description

#Restart single team env
1. admin - run (scripts/admin_setup/delete_team_env.sh) make sure you provided correct service account
2. team - get back to #RUN#step4

#cleanup:
1. script clean secrets (script/admin_setup/team_setup/clean_secrets.sh)
2. terraform destroy (terraform cloud)


to test:
- NOT WORKING - what if user wants to restart env  - always using first secret (version1)
#potential workaround - cloud build save image for some reason... - how to fix that
#or dont delete secret when restarting env and use old version
#or use new SA
-DONE what if user publish service account more than 1 time - (tested 5 times - cannot create namespace if exist)

https://docs.google.com/document/d/1sIaESUIIFLzu2BDOL1xRzaiHSGWAXd3h9AYKCFmcKXk/edit
Desc to Jason:
Time is of the essence, and the company's future hinges on your success. Can you navigate the restricted environment, secure the necessary secrets, and deploy the game before it's game over? Fix deployments, unlock secrets, master limited access, win the glory!

You're part of a team at Starlight Citadel Games, tasked with deploying the first pre-alpha version of a new adventure game to a Kubernetes cluster. While security is taken as the highest priority, so your access will be limited, the admins had an argument about the database credentials, which has sent one of them to hospital and the wrong credentials to the deployment. This application is very important to the company as they see their future success in it, so make sure that it can be up and running as fast as possible!

A first draft of the challenge:
We should have a multitenant GKE cluster prepared, every team should get their own namespace in the cluster. The cluster we can create beforehand, the namespaces can be created quickly. That GKE is in a different project none of the teams have access for.
When they start the challenge, they get their own project with a service account and a namespace in the multitenant cluster. Also a role binding which lets their GCP SA to reach the cluster but their namespace only. So they will have no vision over what other teams are doing, even though all teams will use the same cluster.
Their goal should be to authenticate to the GKE cluster using/impersonating the SA (through console) and create a simple deployment/service or similar which can be easily checked by the scoring system.
Then we can take the Secret Manager part. Like, the app they deployed wants to get some data from a database but cannot authenticate as the credentials have been changed. The new credentials are in secret manager, again, in a project the teams don’t have access to, just the SA has Secret Accessor. 
So, they have to retrieve the secret using the SA and add it to the manifest. If this is too short/easy, we can involve other solutions, like using a GKE secret or Vault.
