resource "kubernetes_manifest" "networkpolicy_allow_scraping" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "networking.k8s.io/v1"
    "kind"       = "NetworkPolicy"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = var.namespace
        "app.kubernetes.io/version"  = var.flux_version
      }
      "name"      = "allow-scraping"
      "namespace" = var.namespace
    }
    "spec" = {
      "ingress" = [
        {
          # kubectl strips this out to prevent API erros but Terraform does not
          # "from" = [
          #   {
          #     "namespaceSelector" = {}
          #   },
          # ]
          "ports" = [
            {
              "port"     = 8080
              "protocol" = "TCP"
            },
          ]
        },
      ]
      "podSelector" = {}
      "policyTypes" = [
        "Ingress",
      ]
    }
  }
}
