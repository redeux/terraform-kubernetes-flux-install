resource "kubernetes_manifest" "networkpolicy_allow_webhooks" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "networking.k8s.io/v1"
    "kind"       = "NetworkPolicy"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = kubernetes_manifest.namespace_flux_system.object.manifest.name
        "app.kubernetes.io/version"  = var.flux_version
      }
      "name"      = "allow-webhooks"
      "namespace" = kubernetes_manifest.namespace_flux_system.object.manifest.name
    }
    "spec" = {
      # kubectl strips this out to prevent API erros but Terraform does not
      # "ingress" = [
      #   {
      #     "from" = [
      #       {
      #         "namespaceSelector" = {}
      #       },
      #     ]
      #   },
      # ]
      "podSelector" = {
        "matchLabels" = {
          "app" = "notification-controller"
        }
      }
      "policyTypes" = [
        "Ingress",
      ]
    }
  }
}
