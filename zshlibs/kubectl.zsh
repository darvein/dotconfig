_k8s_get_images(){
  kubectl get pods -A | awk '{print $1, $2}' | \
    while read -r namespace_name pod_name; do
      kubectl -n $namespace_name get pod $pod_name -o json | \
        jq '.. | .image? // empty' -r | sort | uniq | \
        while read -r docker_image; do
          echo "${namespace_name} ${pod_name} ${docker_image}"
        done
      done
}

_k8s_get_logs(){
  kubectl get pods \
    -n $1 \
    -o name | while read pod; do kubectl logs \
    --tail=100 \
    -f $pod \
    -n $1; done 
}
