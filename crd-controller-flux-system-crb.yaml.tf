resource "kubernetes_manifest" "clusterrolebinding_crd_controller_flux_system" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind"       = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = var.namespace
        "app.kubernetes.io/version"  = var.flux_version
      }
      "name" = "crd-controller-flux-system"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind"     = "ClusterRole"
      "name"     = "crd-controller-flux-system"
    }
    "subjects" = [
      {
        "kind"      = "ServiceAccount"
        "name"      = "kustomize-controller"
        "namespace" = var.namespace
      },
      {
        "kind"      = "ServiceAccount"
        "name"      = "helm-controller"
        "namespace" = var.namespace
      },
      {
        "kind"      = "ServiceAccount"
        "name"      = "source-controller"
        "namespace" = var.namespace
      },
      {
        "kind"      = "ServiceAccount"
        "name"      = "notification-controller"
        "namespace" = var.namespace
      },
      {
        "kind"      = "ServiceAccount"
        "name"      = "image-reflector-controller"
        "namespace" = var.namespace
      },
      {
        "kind"      = "ServiceAccount"
        "name"      = "image-automation-controller"
        "namespace" = var.namespace
      },
    ]
  }
}
