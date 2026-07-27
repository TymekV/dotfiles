def nuke-namespace [namespace: string] {
    kubectl delete namespace $namespace --wait=false
    kubectl get namespace $namespace -o json
    | from json
    | update spec.finalizers []
    | to json
    | kubectl replace --raw $"/api/v1/namespaces/($namespace)/finalize" -f -
}
