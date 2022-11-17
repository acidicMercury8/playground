
alias k="kubectl"
alias kgp="kubectl get pods"
alias kdp="kubectl describe pod"
alias kl="kubectl logs"
alias kpf="kubectl port forward"
alias kgrq="kubectl get ResourceQuota"
alias kgcm="kubectl get cm"
alias kgs="kubectl get secrets"
alias kgsrv="kubectl det service"
alias kgd="kubectl get deployment"
alias kgrs="kubectl get rs"
alias kg="kubectl get"
alias kgi="kubectl get ingress"
alias kd="kubectl describe"
alias kgn="kubectl get nodes"
alias kgss="kubectl get statefulset"
alias kgnp="kubectl get networkpolicies.crd.projectcalico.org "
alias kgns="kubectl get networksets.crd.projectcalico.org"
alias kgvs="kubectl get virtualservices.networking.istio.io "
alias kdvs="kubectl describe virtualservices.networking.istio.io "
function kex(){
    kubectl exec -i -t $1 "--" sh -c "clear; (bash || ash || sh)" 
}

function kexi(){
    kubectl exec -i -t $1 -c istio-proxy  "--" sh -c "clear;(bash || ash || sh)"
}

function klf(){
    kubectl logs $1 > ~/rshb/Debug/broken-pipes/$1.json
}

function klfp(){
    kubectl logs $1 > ~/rshb/Debug/broken-pipes/$1-previous.json
}
