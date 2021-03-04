resource "kubernetes_manifest" "namespace_flux_system" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Namespace"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = var.namespace
        "app.kubernetes.io/version"  = var.flux_version
      }
      "name" = var.namespace
    }
  }
}
