resource "kubernetes_manifest" "service_notification_controller" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Service"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = kubernetes_manifest.namespace_flux_system.object.metadata.name
        "app.kubernetes.io/version"  = var.flux_version
        "control-plane"              = "controller"
      }
      "name"      = "notification-controller"
      "namespace" = kubernetes_manifest.namespace_flux_system.object.metadata.name
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
        "app" = "notification-controller"
      }
      "type" = "ClusterIP"
    }
  }
}
