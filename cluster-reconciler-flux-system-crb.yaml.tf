resource "kubernetes_manifest" "clusterrolebinding_cluster_reconciler_flux_system" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind"       = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = kubernetes_manifest.namespace_flux_system.object.metadata.name
        "app.kubernetes.io/version"  = var.flux_version
      }
      "name" = "cluster-reconciler-flux-system"
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind"     = "ClusterRole"
      "name"     = "cluster-admin"
    }
    "subjects" = [
      {
        "kind"      = "ServiceAccount"
        "name"      = "kustomize-controller"
        "namespace" = kubernetes_manifest.namespace_flux_system.object.metadata.name
      },
      {
        "kind"      = "ServiceAccount"
        "name"      = "helm-controller"
        "namespace" = kubernetes_manifest.namespace_flux_system.object.metadata.name
      },
    ]
  }
}
