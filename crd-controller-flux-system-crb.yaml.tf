resource "kubernetes_manifest" "clusterrolebinding_crd_controller_flux_system" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind"       = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = kubernetes_manifest.namespace_flux_system.object.manifest.name
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
        "namespace" = kubernetes_manifest.namespace_flux_system.object.manifest.name
      },
      {
        "kind"      = "ServiceAccount"
        "name"      = "helm-controller"
        "namespace" = kubernetes_manifest.namespace_flux_system.object.manifest.name
      },
      {
        "kind"      = "ServiceAccount"
        "name"      = "source-controller"
        "namespace" = kubernetes_manifest.namespace_flux_system.object.manifest.name
      },
      {
        "kind"      = "ServiceAccount"
        "name"      = "notification-controller"
        "namespace" = kubernetes_manifest.namespace_flux_system.object.manifest.name
      },
      {
        "kind"      = "ServiceAccount"
        "name"      = "image-reflector-controller"
        "namespace" = kubernetes_manifest.namespace_flux_system.object.manifest.name
      },
      {
        "kind"      = "ServiceAccount"
        "name"      = "image-automation-controller"
        "namespace" = kubernetes_manifest.namespace_flux_system.object.manifest.name
      },
    ]
  }
}
