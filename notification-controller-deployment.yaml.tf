resource "kubernetes_manifest" "deployment_notification_controller" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "apps/v1"
    "kind"       = "Deployment"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = kubernetes_manifest.namespace_flux_system.object.manifest.name
        "app.kubernetes.io/version"  = var.flux_version
        "control-plane"              = "controller"
      }
      "name"      = "notification-controller"
      "namespace" = kubernetes_manifest.namespace_flux_system.object.manifest.name
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app" = "notification-controller"
        }
      }
      "template" = {
        "metadata" = {
          "annotations" = {
            "prometheus.io/port"   = "8080"
            "prometheus.io/scrape" = "true"
          }
          "labels" = {
            "app" = "notification-controller"
          }
        }
        "spec" = {
          "containers" = [
            {
              "args" = [
                "--watch-all-namespaces=${var.watch_all_namespaces}",
                var.log_level,
                "--log-encoding=json",
                "--enable-leader-election",
              ]
              "env" = [
                {
                  "name" = "RUNTIME_NAMESPACE"
                  "valueFrom" = {
                    "fieldRef" = {
                      "fieldPath" = "metadata.namespace"
                    }
                  }
                },
              ]
              "image"           = "${var.registry}/notification-controller:v0.9.0"
              "imagePullPolicy" = "IfNotPresent"
              "livenessProbe" = {
                "httpGet" = {
                  "path" = "/healthz"
                  "port" = "healthz"
                }
              }
              "name" = "manager"
              "ports" = [
                {
                  "containerPort" = 9440
                  "name"          = "healthz"
                  "protocol"      = "TCP"
                },
                {
                  "containerPort" = 9090
                  "name"          = "http"
                  #protocol absent from manifest but required by TF
                  "protocol" = "TCP"
                },
                {
                  "containerPort" = 9292
                  "name"          = "http-webhook"
                  #protocol absent from manifest but required by TF
                  "protocol" = "TCP"
                },
                {
                  "containerPort" = 8080
                  "name"          = "http-prom"
                  #protocol absent from manifest but required by TF
                  "protocol" = "TCP"
                },
              ]
              "readinessProbe" = {
                "httpGet" = {
                  "path" = "/readyz"
                  "port" = "healthz"
                }
              }
              "resources" = {
                "limits" = {
                  "cpu"    = "1"
                  "memory" = "1Gi"
                }
                "requests" = {
                  "cpu"    = "100m"
                  "memory" = "64Mi"
                }
              }
              "securityContext" = {
                "allowPrivilegeEscalation" = false
                "readOnlyRootFilesystem"   = true
              }
              "volumeMounts" = [
                {
                  "mountPath" = "/tmp"
                  "name"      = "temp"
                },
              ]
            },
          ]
          "nodeSelector" = {
            "kubernetes.io/os" = "linux"
          }
          "serviceAccountName"            = "notification-controller"
          "terminationGracePeriodSeconds" = 10
          "volumes" = [
            {
              "emptyDir" = {}
              "name"     = "temp"
            },
          ]
        }
      }
    }
  }
}
