resource "kubernetes_manifest" "clusterrole_crd_controller_flux_system" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind"       = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = var.namespace
        "app.kubernetes.io/version"  = var.flux_version
      }
      "name" = "crd-controller-flux-system"
    }
    "rules" = [
      {
        "apiGroups" = [
          "source.toolkit.fluxcd.io",
        ]
        "resources" = [
          "*",
        ]
        "verbs" = [
          "*",
        ]
      },
      {
        "apiGroups" = [
          "kustomize.toolkit.fluxcd.io",
        ]
        "resources" = [
          "*",
        ]
        "verbs" = [
          "*",
        ]
      },
      {
        "apiGroups" = [
          "helm.toolkit.fluxcd.io",
        ]
        "resources" = [
          "*",
        ]
        "verbs" = [
          "*",
        ]
      },
      {
        "apiGroups" = [
          "notification.toolkit.fluxcd.io",
        ]
        "resources" = [
          "*",
        ]
        "verbs" = [
          "*",
        ]
      },
      {
        "apiGroups" = [
          "image.toolkit.fluxcd.io",
        ]
        "resources" = [
          "*",
        ]
        "verbs" = [
          "*",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "secrets",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "events",
        ]
        "verbs" = [
          "create",
          "patch",
        ]
      },
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "configmaps",
          "configmaps/status",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
          "create",
          "update",
          "patch",
          "delete",
        ]
      },
      {
        "apiGroups" = [
          "coordination.k8s.io",
        ]
        "resources" = [
          "leases",
        ]
        "verbs" = [
          "get",
          "list",
          "watch",
          "create",
          "update",
          "patch",
          "delete",
        ]
      },
    ]
  }
}
