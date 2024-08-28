### Install K3D & check
```sh
wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
k3d version
kubectl cluster-info
```

### Install ARGOCD
```sh
k3d cluster create argo
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl port-forward svc/argocd-server -n argocd 8080:443 --address 0.0.0.0
```

### Open Web UI ARGOCD
See the admin password
```sh
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```
Open web browser with externalIPs:8080 

Enter admin & "password"
