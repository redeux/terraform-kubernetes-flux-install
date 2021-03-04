resource "kubernetes_manifest" "networkpolicy_deny_ingress" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "networking.k8s.io/v1"
    "kind"       = "NetworkPolicy"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = kubernetes_manifest.namespace_flux_system.object.metadata.name
        "app.kubernetes.io/version"  = var.flux_version
      }
      "name"      = "deny-ingress"
      "namespace" = kubernetes_manifest.namespace_flux_system.object.metadata.name
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
