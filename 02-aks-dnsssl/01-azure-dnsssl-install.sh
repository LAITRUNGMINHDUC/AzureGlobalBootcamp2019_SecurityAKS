NAME='letsencrypt-ssl'
INGRESS_DNS_NAMESPACE='ingress-nginx'

helm install stable/cert-manager --version v0.5.2 \
    --namespace $INGRESS_DNS_NAMESPACE \
    --name $NAME \
    --set ingressShim.defaultIssuerName=letsencrypt-prod \
    --set ingressShim.defaultIssuerKind=ClusterIssuer

kubectl apply -f azure-dnsssl-issuer.yaml

kubectl apply -f azure-dnsssl-certificate.yaml
