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

kubectl get pods --all-namespaces
kubectl -n flux rollout status deployment/flux
fluxctl identity --k8s-fwd-ns flux

echo "Copy that RSA key, and let's head back over to GitHub."

fluxctl sync --k8s-fwd-ns flux

kubectl get namespaces

kubectl get pods --namespace=lasample
