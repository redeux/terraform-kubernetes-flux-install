resource "kubernetes_manifest" "service_webhook_receiver" {
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
      "name"      = "webhook-receiver"
      "namespace" = var.namespace
    }
    "spec" = {
      "ports" = [
        {
          "name"       = "http"
          "port"       = 80
          "protocol"   = "TCP"
          "targetPort" = "http-webhook"
        },
      ]
      "selector" = {
        "app" = "notification-controller"
      }
      "type" = "ClusterIP"
    }
  }
}
