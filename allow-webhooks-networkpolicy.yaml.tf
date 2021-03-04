resource "kubernetes_manifest" "networkpolicy_allow_webhooks" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "networking.k8s.io/v1"
    "kind"       = "NetworkPolicy"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = var.namespace
        "app.kubernetes.io/version"  = var.flux_version
      }
      "name"      = "allow-webhooks"
      "namespace" = var.namespace
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
