resource "kubernetes_manifest" "service_source_controller" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Service"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = var.namespace
        "app.kubernetes.io/version"  = var.flux_version
        "control-plane"              = "controller"
      }
      "name"      = "source-controller"
      "namespace" = var.namespace
    }
    "spec" = {
      "ports" = [
        {
          "name"       = "http"
          "port"       = 80
          "protocol"   = "TCP"
          "targetPort" = "http"
        },
      ]
      "selector" = {
        "app" = "source-controller"
      }
      "type" = "ClusterIP"
    }
  }
}
