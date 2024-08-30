# Move the plugin into your $PATH
```sh
sudo chmod +x ./kubectl-kubeplugin
sudo mv ./kubectl-kubeplugin /usr/local/bin
```

# You can now invoke your plugin via kubectl:
```sh
kubectl kubeplugin --COMMAND=get --rt=pods --namespace=demo
```
```sh
kubectl kubeplugin --COMMAND=top --rt=nodes --namespace=default
```

Example:
```sh
Resource: pods, Namespace: demo, Name: demo-ascii-7f445f878d-ql5vj, CPU: 6m, Memory: 4Mi
Resource: pods, Namespace: demo, Name: demo-data-8555ddd645-xtm2p, CPU: 6m, Memory: 4Mi
```
