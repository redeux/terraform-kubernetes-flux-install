# Flux v2 Install with Terraform

This Terraform module is (almost) the equivalent of using the Flux CLI to install Flux v2 in to your Kubernetes cluster.

This module was mostly generated from the output of Flux CLI, using the command `flux install --export > flux-system.yaml`.  From there, the multi-doc yaml file that the Flux CLI produces was converted into individual yaml files using [mogensen/kubernetes-split-yaml](https://github.com/mogensen/kubernetes-split-yaml). Finally the yaml files were converted to HCL using [jrhouston/tfk8s](https://github.com/jrhouston/tfk8s). 

Variables were still done by hand, unfortunately.

## Usage

```
terraform {
required_version = ">=0.15.0"
required_providers {
    kubernetes-alpha = {
      source  = "hashicorp/kubernetes-alpha"
      version = ">=0.3.0"
    }
  }
}

provider "kubernetes-alpha" {
  config_path = "~/.kube/config"
}

module "flux_install" {
  source = "github.com/redeux/terraform-kubernetes-flux-install"
}
```

## TODO
--components strings         list of components, accepts comma-separated values (default [source-controller,kustomize-controller,helm-controller,notification-controller])

Variables implemented, but not conditionals

--image-pull-secret string   Kubernetes secret name used for pulling the toolkit images from a private registry

--network-policy             deny ingress access to the toolkit controllers from other namespaces using network policies (default true)


--toleration-keys strings    list of toleration keys used to schedule the components pods onto nodes with matching taints