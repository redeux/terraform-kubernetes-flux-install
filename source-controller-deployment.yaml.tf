resource "kubernetes_manifest" "deployment_source_controller" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "apps/v1"
    "kind"       = "Deployment"
    "metadata" = {
      "labels" = {
        "app.kubernetes.io/instance" = var.namespace
        "app.kubernetes.io/version"  = var.flux_version
        "control-plane"              = "controller"
      }
      "name"      = "source-controller"
      "namespace" = var.namespace
    }
    "spec" = {
      "replicas" = 1
      "selector" = {
        "matchLabels" = {
          "app" = "source-controller"
        }
      }
      "strategy" = {
        "type" = "Recreate"
      }
      "template" = {
        "metadata" = {
          "annotations" = {
            "prometheus.io/port"   = "8080"
            "prometheus.io/scrape" = "true"
          }
          "labels" = {
            "app" = "source-controller"
          }
        }
        "spec" = {
          "containers" = [
            {
              "args" = [
                "--events-addr=http://notification-controller/",
                "--watch-all-namespaces=${var.watch_all_namespaces}",
                var.log_level,
                "--log-encoding=json",
                "--enable-leader-election",
                "--storage-path=/data",
                "--storage-adv-addr=source-controller.$(RUNTIME_NAMESPACE).svc.${var.cluster_domain}.",
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
              "image"           = "${var.registry}/source-controller:v0.9.0"
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
                  "containerPort" = 9090
                  "name"          = "http"
                  #protocol absent from manifest but required by TF
                  "protocol" = "TCP"
                },
                {
                  "containerPort" = 8080
                  "name"          = "http-prom"
                  #protocol absent from manifest but required by TF
                  "protocol" = "TCP"
                },
                {
                  "containerPort" = 9440
                  "name"          = "healthz"
                  #protocol absent from manifest but required by TF
                  "protocol" = "TCP"
                },
              ]
              "readinessProbe" = {
                "httpGet" = {
                  "path" = "/"
                  "port" = "http"
                }
              }
              "resources" = {
                "limits" = {
                  "cpu"    = "1"
                  "memory" = "1Gi"
                }
                "requests" = {
                  "cpu"    = "50m"
                  "memory" = "64Mi"
                }
              }
              "securityContext" = {
                "allowPrivilegeEscalation" = false
                "readOnlyRootFilesystem"   = true
              }
              "volumeMounts" = [
                {
                  "mountPath" = "/data"
                  "name"      = "data"
                },
                {
                  "mountPath" = "/tmp"
                  "name"      = "tmp"
                },
              ]
            },
          ]
          "nodeSelector" = {
            "kubernetes.io/os" = "linux"
          }
          "securityContext" = {
            "fsGroup" = 1337
          }
          "serviceAccountName"            = "source-controller"
          "terminationGracePeriodSeconds" = 10
          "volumes" = [
            {
              "emptyDir" = {}
              "name"     = "data"
            },
            {
              "emptyDir" = {}
              "name"     = "tmp"
            },
          ]
        }
      }
    }
  }
}
