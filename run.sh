
echo "Deploy Flux Into Your Cluster"
kubectl get nodes
fluxctl version
kubectl get pods --all-namespace
kubectl create namespace flux
kubectl get namespaces
export GHUSER=guilhermerodriguesti
env | grep GH

fluxctl install \
--git-user=${GHUSER} \
--git-email=${GHUSER}@users.noreply.github.com \
--git-url=git@github.com:${GHUSER}/content-gitops \
--git-path=namespaces,workloads \
--namespace=flux | kubectl apply -f -

echo "Verify The Deployment and Obtain the RSA Key"

kubectl get pods --all-namespaces
kubectl -n flux rollout status deployment/flux

echo "Copy that RSA key, and let's head back over to GitHub."
#Implement the RSA Key in GitHub
#In the GitHub user interface, make sure we're in our new repository and click on the Settings tab. In there, click Deploy keys, then click the Add deploy key button. We can give it a Title of something like GitOps Deploy Key, then paste the key we copied earlier down in the Key field. Check the Allow write access box, and then click Add key

fluxctl identity --k8s-fwd-ns flux

fluxctl sync --k8s-fwd-ns flux

kubectl get namespaces

kubectl get pods --namespace=lasample
