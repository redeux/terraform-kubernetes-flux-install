resource "kubernetes_manifest" "serviceaccount_source_controller" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind"       = "ServiceAccount"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = kubernetes_manifest.namespace_flux_system.object.metadata.name
        "app.kubernetes.io/version"  = var.flux_version
      }
      "name"      = "source-controller"
      "namespace" = kubernetes_manifest.namespace_flux_system.object.metadata.name
    }
  }
}
