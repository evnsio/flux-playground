# Setup

## Install Helm

Follow the instructions [here](https://docs.helm.sh/using_helm/#quickstart).

Deploy the Helm RBAC

## Install flux and the helm operator

Install flux and flux-helm with the `flux` chart:

```
helm upgrade -i flux charts/flux
```

## Configure `fluxctl`

Fluxctl is the CLI tool for interacting with flux.

The binary can be downloaded from [here](https://github.com/weaveworks/flux/releases)

```
fluxport=$(kubectl get svc flux --template '{{ index .spec.ports 0 "nodePort" }}')
export FLUX_URL="http://$(minikube ip):$fluxport/api/flux"
```

## Configure the git repo

For flux to work, it needs to be able to read from and write to the source git repo.

To enable this, we need to add the auto-generated SSH key to GitHub.

We can extract the public key using fluxctl, or by looking in the flux pod logs:

```
$ fluxctl identity
```

or

```
$ kubectl logs flux-5896444d98-d7gxk
```
