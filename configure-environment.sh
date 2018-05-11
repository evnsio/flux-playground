#! /bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' 

#
# Install the prerequisite kubernetes resources
#
echo -e "${GREEN}[ INFO ] Applying Prerequisites${NC}"
kubectl apply -f prereqs/   

#
# Initialise Helm
#
echo -e "\n${GREEN}[ INFO ] Initialising Helm${NC}"
helm init --wait --service-account tiller

#
# Create namespace for flux resources
#
echo -e "\n${GREEN}[ INFO ] Create weave namespace${NC}"
kubectl create namespace weave

#
# Install flux
#
echo -e "\n${GREEN}[ INFO ] Installing Flux${NC}"
helm upgrade -i flux charts/flux

flux_pod=`kubectl get pod -n weave --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' | grep flux | grep -v flux-helm`

until kubectl get pod -n weave ${flux_pod} | grep 1/1 > /dev/null
do
echo "Waiting for Flux to be ready..."
sleep 2
done

echo -e "\n${GREEN}[ INFO ] Add this SSH key to your git repo:${NC}"
kubectl logs -n weave ${flux_pod} | grep identity.pub | sed -n 's/.*\identity\.pub="\(.*\)\\n.*/\1/p'

echo -e "\n${GREEN}[ INFO ] Environment Successfully Configured 🙌${NC}\n"
