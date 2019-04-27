INGRESS_NAMESPACE='ingress-nginx'
for p in $(kubectl get pods -n $INGRESS_NAMESPACE | \
        grep 'nginx-ingress-controller' | \
        cut -f 1 -d ' '); do 
    echo --------------------------- 
    echo $p 
    echo --------------------------- 
    kubectl logs -n $INGRESS_NAMESPACE $p | grep "lua"
done