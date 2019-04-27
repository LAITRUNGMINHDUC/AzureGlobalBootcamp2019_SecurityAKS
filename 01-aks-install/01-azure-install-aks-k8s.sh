# Create Azure Active Directory - App Registration
# Tutorial at: https://docs.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal
APPID='257c28cc-93f2-463e-9bd7-a7e7fb7c4f48' # Prepare at Pre-requisite 
APPSECRET='j)8#}%=([@v*f_{{x%F*=)A#@*/' # Prepare at Pre-requisite

AZURE_GROUPNAME='AzureBootcamp-AKS' # Group of resource for Azure managing
AZURE_KUBE_CLUSTER_NAME='AzureBootcamp-KUBE' # Name of Kubernetes Cluster
AZURE_KUBE_NODE='1' # Number of Node in Cluster
AZURE_KUBE_NODE_SIZE='Standard_B2s' 
#Performance of NODE: https://azure.microsoft.com/en-us/blog/introducing-burstable-vm-support-in-aks/

# Create RESOURCE GROUP
az group create --name $AZURE_GROUPNAME --location southeastasia 

# Create AKS Cluster
az aks create --resource-group $AZURE_GROUPNAME \
	--name $AZURE_KUBE_CLUSTER_NAME \
	--node-count $AZURE_KUBE_NODE \
	--node-vm-size $AZURE_KUBE_NODE_SIZE \
	--enable-addons monitoring \
	--service-principal $APPID \
	--client-secret $APPSECRET \
	--generate-ssh-keys

# Get AKS Credential
az aks get-credentials --resource-group $AZURE_GROUPNAME --name $AZURE_KUBE_CLUSTER_NAME

# Create RBAC role for Dashboard
kubectl create clusterrolebinding kubernetes-dashboard \ 
				-n kube-system --clusterrole=cluster-admin \
				--serviceaccount=kube-system:kubernetes-dashboard
