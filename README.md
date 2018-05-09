# Setup

## Install flux

Edit the args supplied to the flux daemon:

```
$ vim environments/<env-name>/flux/deploy/flux-deployment.yaml
```

At least the arguments for the git url and path should be updated.

Apply the configuration to Kubernetes:

```
$ kc apply -f environments/<env-name>/flux/deploy
```

## Configure `fluxctl`

Fluxctl is the CLI tool for interacting with flux.

The binary can be downloaded from [here](https://github.com/weaveworks/flux/releases)

```
$ fluxport=$(kubectl get svc flux --template '{{ index .spec.ports 0 "nodePort" }}')
$ export FLUX_URL="http://$(minikube ip):$fluxport/api/flux"
```

## Configure the git repo

For flux to work, it needs to be able to read from and write to the source git repo.

To enable this, we need to add the auto-generated SSH key to GitHub.

We can extract the public key using fluxctl.  

```
$ fluxctl identity
```

Alternatively, we can extract the key from the flux pod logs, for example:

```
$ kubectl logs flux-5896444d98-d7gxk
```
