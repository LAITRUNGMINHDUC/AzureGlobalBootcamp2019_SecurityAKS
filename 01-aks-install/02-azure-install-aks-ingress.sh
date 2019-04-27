NAME='ingress-nginx' # Ingress name for managing easier
INGRESS_DNS_NAMESPACE='ingress-nginx' # Kubernetes namespace for Ingress 
# for seperating Ingress with other application

kubectl apply -f azure-helm-rbac.yaml #https://docs.microsoft.com/en-us/azure/aks/kubernetes-helm
kubectl create clusterrolebinding add-on-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:default
helm init --service-account tiller

kubectl create namespace $INGRESS_DNS_NAMESPACE

sleep 5

helm install stable/nginx-ingress \
	--name $NAME \
	--namespace $INGRESS_DNS_NAMESPACE \
	--set controller.replicaCount=2 \
	--set rbac.create=true

sleep 10 # Wait 10 seconds for NGINX Ingress successfully install and load IP

# Change traffic policy to see outside IP
kubectl patch svc $NAME-nginx-ingress-controller \
		-p '{"spec":{"externalTrafficPolicy":"Local"}}' \
		-n $INGRESS_DNS_NAMESPACE

# Get IP of Ingress
kubectl get svc -n $INGRESS_DNS_NAMESPACE
