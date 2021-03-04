resource "kubernetes_manifest" "service_webhook_receiver" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Service"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = kubernetes_manifest.namespace_flux_system.object.manifest.name
        "app.kubernetes.io/version"  = var.flux_version
        "control-plane"              = "controller"
      }
      "name"      = "webhook-receiver"
      "namespace" = kubernetes_manifest.namespace_flux_system.object.manifest.name
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
