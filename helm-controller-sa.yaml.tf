resource "kubernetes_manifest" "serviceaccount_helm_controller" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind"       = "ServiceAccount"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = kubernetes_manifest.namespace_flux_system.object.manifest.name
        "app.kubernetes.io/version"  = var.flux_version
      }
      "name"      = "helm-controller"
      "namespace" = kubernetes_manifest.namespace_flux_system.object.manifest.name
    }
  }
}
