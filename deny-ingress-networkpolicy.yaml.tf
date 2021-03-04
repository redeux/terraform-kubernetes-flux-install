resource "kubernetes_manifest" "networkpolicy_deny_ingress" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "networking.k8s.io/v1"
    "kind"       = "NetworkPolicy"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = var.namespace
        "app.kubernetes.io/version"  = var.flux_version
      }
      "name"      = "deny-ingress"
      "namespace" = var.namespace
    }
    "spec" = {
      # kubectl strips this out to prevent API erros but Terraform does not
      # "egress" = [
      #   {},
      # ]
      # "ingress" = [
      #   {
      #     "from" = [
      #       {
      #         "podSelector" = {}
      #       },
      #     ]
      #   },
      # ]
      "podSelector" = {}
      "policyTypes" = [
        "Ingress",
        "Egress",
      ]
    }
  }
}
