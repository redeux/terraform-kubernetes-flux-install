resource "kubernetes_manifest" "networkpolicy_allow_scraping" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "networking.k8s.io/v1"
    "kind"       = "NetworkPolicy"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = kubernetes_manifest.namespace_flux_system.object.manifest.name
        "app.kubernetes.io/version"  = var.flux_version
      }
      "name"      = "allow-scraping"
      "namespace" = kubernetes_manifest.namespace_flux_system.object.manifest.name
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
