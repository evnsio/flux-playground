# Setup

## Install flux

Edit the args supplied to the flux daemon:

```
$EDITOR flux/deploy/flux-deployment.yaml
```

At least the arguments for the git url and path should be updated.

Apply the configuration to Kubernetes:

```
kc apply -f flux/deploy
```

## Configure `fluxctl`

Fluxctl is the CLI tool for interacting with flux.

The binary can be downloaded from [here](https://github.com/weaveworks/flux/releases)

```
fluxport=$(kubectl get svc flux --template '{{ index .spec.ports 0 "nodePort" }}')
export FLUX_URL="http://$(minikube ip):$fluxport/api/flux"
```

## Configure the git repo

For flux to work, it needs to be able to read and write to the source git repo.

To enable this, we need to add the auto-generated SSH key to GitHub.

We can extract the public key using fluxctl.  

```
fluxctl identity

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDrVsVWSTeQ+dpx8AE46qmjx7cyykKG7khSPYEq1vqEM5aE7dBgKHcfoy1V/TmghzUiWYK9YfGz1YIaonCUh93uR0rzrOcFCDpkPfpBAx8EbCs3bCAJ4wQXtrSAAE4eHAxmbWHupsiom4UPvT0tCjkYXn8KCWCCkc7ldpq8nIZIsrknniXJ3wpSXrag8x2pLmtxVVifHFovuDmrSO/IVFuyuzc3JFVX98ZguprxA9rkPnWzd605uinsWWLvwZhkOfQpZbe7ua97O0a/pMAfV8hg/2oY50epqrIsYZYxC1UyCa0Lhee7k/kFGO8AFFJhrn5jDFmEQ56ikAYvdVBUk1/R
```
