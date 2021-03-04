resource "kubernetes_manifest" "serviceaccount_helm_controller" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind"       = "ServiceAccount"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = var.namespace
        "app.kubernetes.io/version"  = var.flux_version
      }
      "name"      = "helm-controller"
      "namespace" = var.namespace
    }
  }
}
