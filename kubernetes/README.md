https://downey.io/notes/dev/kubectl-exec-multiple-pods/

Kubeconfig update,

```sh
 aws eks --region <region> update-kubeconfig --name <config_name>
```

Kubernetes pod restart investigation helpers,

```sh
kubectl get deployment -n <namespace>
```

```sh
 kubectl describe deployment <deployment_name> -n <namespace>
```

```sh
kubectl describe pod <pod_name> -n <namespace>
```
