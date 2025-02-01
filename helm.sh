#!/bin/bash
## 0 Install helm
#curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
#
### 1. Add nginx
#helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
#helm repo update
#helm install my-nginx ingress-nginx/ingress-nginx
#
#helm repo add bitnami https://charts.bitnami.com/bitnami
#helm repo update
#helm install my-apache bitnami/apache

# 1. Install Jenkins without the persistence
helm install my-jenkins jenkins/jenkins --set persistence.enabled=false

# 2. Get the admin password
kubectl exec --namespace default -it svc/my-jenkins -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo

# 3. Map the local port towards the Jenkins services
kubectl --namespace default port-forward svc/my-jenkins 8080:8080

# 4. Login to the Jenkins console
http://127.0.0.1:8080

