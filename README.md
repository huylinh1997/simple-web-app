## Setup webhook 
Github : create webhook 
    Webhook  : http://Jenkins_URL/github-webhook/
    www urlencoded 

Jenkins : select  GitHub hook trigger for GITScm polling


## add this to containerd config node   /etc/containerd/config.toml to bypass error about tls

[plugins."io.containerd.grpc.v1.cri".registry]
  [plugins."io.containerd.grpc.v1.cri".registry.mirrors]
    [plugins."io.containerd.grpc.v1.cri".registry.mirrors."<IP>:5000"]
      endpoint = ["http://<IP>:5000"]
  [plugins."io.containerd.grpc.v1.cri".registry.configs]
    [plugins."io.containerd.grpc.v1.cri".registry.configs."<IP>:5000".tls]
      insecure_skip_verify = true

## create secret docker hub or private registry 

kubectl create secret docker-registry docker-credentials \ 
    --docker-username="username"  \
    --docker-password="password" \

kubectl create secret docker-registry harbor-registry-secret \
    --docker-server="https://harbor.local:30003/" \
    --docker-username="username"  \
    --docker-password="username"


## Setup kubernetes cloud