# Public IP address of your ingress controller
IP="23.98.74.41" 

# Name of Ingress in azure-install-aks-ingress.sh
DNSNAME="ingress-nginx"

# Get the resource-id of the public ip
PUBLICIPID=$(az network public-ip list --query "[?ipAddress!=null]|[?contains(ipAddress, '$IP')].[id]" --output tsv)

# Update public ip address with DNS name
az network public-ip update --ids $PUBLICIPID --dns-name $DNSNAME
