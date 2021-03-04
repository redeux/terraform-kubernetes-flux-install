resource "kubernetes_manifest" "customresourcedefinition_helmcharts_source_toolkit_fluxcd_io" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind"       = "CustomResourceDefinition"
    "metadata" = {
      "annotations" = {
        "controller-gen.kubebuilder.io/version" = "v0.4.1"
      }
      "labels" = {
        "app.kubernetes.io/instance" = var.namespace
        "app.kubernetes.io/version"  = var.flux_version
      }
      "name" = "helmcharts.source.toolkit.fluxcd.io"
    }
    "spec" = {
      "group" = "source.toolkit.fluxcd.io"
      "names" = {
        "kind"     = "HelmChart"
        "listKind" = "HelmChartList"
        "plural"   = "helmcharts"
        "singular" = "helmchart"
      }
      "scope" = "Namespaced"
      "versions" = [
        {
          "additionalPrinterColumns" = [
            {
              "jsonPath" = ".spec.chart"
              "name"     = "Chart"
              "type"     = "string"
            },
            {
              "jsonPath" = ".spec.version"
              "name"     = "Version"
              "type"     = "string"
            },
            {
              "jsonPath" = ".spec.sourceRef.kind"
              "name"     = "Source Kind"
              "type"     = "string"
            },
            {
              "jsonPath" = ".spec.sourceRef.name"
              "name"     = "Source Name"
              "type"     = "string"
            },
            {
              "jsonPath" = ".status.conditions[?(@.type==\"Ready\")].status"
              "name"     = "Ready"
              "type"     = "string"
            },
            {
              "jsonPath" = ".status.conditions[?(@.type==\"Ready\")].message"
              "name"     = "Status"
              "type"     = "string"
            },
            {
              "jsonPath" = ".metadata.creationTimestamp"
              "name"     = "Age"
              "type"     = "date"
            },
          ]
          "name" = "v1beta1"
          "schema" = {
            "openAPIV3Schema" = {
              "description" = "HelmChart is the Schema for the helmcharts API"
              "properties" = {
                "apiVersion" = {
                  "description" = "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
                  "type"        = "string"
                }
                "kind" = {
                  "description" = "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
                  "type"        = "string"
                }
                "metadata" = {
                  "type" = "object"
                }
                "spec" = {
                  "description" = "HelmChartSpec defines the desired state of a Helm chart."
                  "properties" = {
                    "chart" = {
                      "description" = "The name or path the Helm chart is available at in the SourceRef."
                      "type"        = "string"
                    }
                    "interval" = {
                      "description" = "The interval at which to check the Source for updates."
                      "type"        = "string"
                    }
                    "sourceRef" = {
                      "description" = "The reference to the Source the chart is available at."
                      "properties" = {
                        "apiVersion" = {
                          "description" = "APIVersion of the referent."
                          "type"        = "string"
                        }
                        "kind" = {
                          "description" = "Kind of the referent, valid values are ('HelmRepository', 'GitRepository', 'Bucket')."
                          "enum" = [
                            "HelmRepository",
                            "GitRepository",
                            "Bucket",
                          ]
                          "type" = "string"
                        }
                        "name" = {
                          "description" = "Name of the referent."
                          "type"        = "string"
                        }
                      }
                      "required" = [
                        "kind",
                        "name",
                      ]
                      "type" = "object"
                    }
                    "suspend" = {
                      "description" = "This flag tells the controller to suspend the reconciliation of this source."
                      "type"        = "boolean"
                    }
                    "valuesFile" = {
                      "description" = "Alternative values file to use as the default chart values, expected to be a relative path in the SourceRef. Ignored when omitted."
                      "type"        = "string"
                    }
                    "version" = {
                      "default"     = "*"
                      "description" = "The chart version semver expression, ignored for charts from GitRepository and Bucket sources. Defaults to latest when omitted."
                      "type"        = "string"
                    }
                  }
                  "required" = [
                    "chart",
                    "interval",
                    "sourceRef",
                  ]
                  "type" = "object"
                }
                "status" = {
                  "description" = "HelmChartStatus defines the observed state of the HelmChart."
                  "properties" = {
                    "artifact" = {
                      "description" = "Artifact represents the output of the last successful chart sync."
                      "properties" = {
                        "checksum" = {
                          "description" = "Checksum is the SHA1 checksum of the artifact."
                          "type"        = "string"
                        }
                        "lastUpdateTime" = {
                          "description" = "LastUpdateTime is the timestamp corresponding to the last update of this artifact."
                          "format"      = "date-time"
                          "type"        = "string"
                        }
                        "path" = {
                          "description" = "Path is the relative file path of this artifact."
                          "type"        = "string"
                        }
                        "revision" = {
                          "description" = "Revision is a human readable identifier traceable in the origin source system. It can be a Git commit SHA, Git tag, a Helm index timestamp, a Helm chart version, etc."
                          "type"        = "string"
                        }
                        "url" = {
                          "description" = "URL is the HTTP address of this artifact."
                          "type"        = "string"
                        }
                      }
                      "required" = [
                        "path",
                        "url",
                      ]
                      "type" = "object"
                    }
                    "conditions" = {
                      "description" = "Conditions holds the conditions for the HelmChart."
                      "items" = {
                        "description" = "Condition contains details for one aspect of the current state of this API Resource. --- This struct is intended for direct use as an array at the field path .status.conditions.  For example, type FooStatus struct{     // Represents the observations of a foo's current state.     // Known .status.conditions.type are: \"Available\", \"Progressing\", and \"Degraded\"     // +patchMergeKey=type     // +patchStrategy=merge     // +listType=map     // +listMapKey=type     Conditions []metav1.Condition `json:\"conditions,omitempty\" patchStrategy:\"merge\" patchMergeKey:\"type\" protobuf:\"bytes,1,rep,name=conditions\"` \n     // other fields }"
                        "properties" = {
                          "lastTransitionTime" = {
                            "description" = "lastTransitionTime is the last time the condition transitioned from one status to another. This should be when the underlying condition changed.  If that is not known, then using the time when the API field changed is acceptable."
                            "format"      = "date-time"
                            "type"        = "string"
                          }
                          "message" = {
                            "description" = "message is a human readable message indicating details about the transition. This may be an empty string."
                            "maxLength"   = 32768
                            "type"        = "string"
                          }
                          "observedGeneration" = {
                            "description" = "observedGeneration represents the .metadata.generation that the condition was set based upon. For instance, if .metadata.generation is currently 12, but the .status.conditions[x].observedGeneration is 9, the condition is out of date with respect to the current state of the instance."
                            "format"      = "int64"
                            "minimum"     = 0
                            "type"        = "integer"
                          }
                          "reason" = {
                            "description" = "reason contains a programmatic identifier indicating the reason for the condition's last transition. Producers of specific condition types may define expected values and meanings for this field, and whether the values are considered a guaranteed API. The value should be a CamelCase string. This field may not be empty."
                            "maxLength"   = 1024
                            "minLength"   = 1
                            "pattern"     = "^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
                            "type"        = "string"
                          }
                          "status" = {
                            "description" = "status of the condition, one of True, False, Unknown."
                            "enum" = [
                              "True",
                              "False",
                              "Unknown",
                            ]
                            "type" = "string"
                          }
                          "type" = {
                            "description" = "type of condition in CamelCase or in foo.example.com/CamelCase. --- Many .condition.type values are consistent across resources like Available, but because arbitrary conditions can be useful (see .node.status.conditions), the ability to deconflict is important. The regex it matches is (dns1123SubdomainFmt/)?(qualifiedNameFmt)"
                            "maxLength"   = 316
                            "pattern"     = "^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
                            "type"        = "string"
                          }
                        }
                        "required" = [
                          "lastTransitionTime",
                          "message",
                          "reason",
                          "status",
                          "type",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "lastHandledReconcileAt" = {
                      "description" = "LastHandledReconcileAt holds the value of the most recent reconcile request value, so a change can be detected."
                      "type"        = "string"
                    }
                    "observedGeneration" = {
                      "description" = "ObservedGeneration is the last observed generation."
                      "format"      = "int64"
                      "type"        = "integer"
                    }
                    "url" = {
                      "description" = "URL is the download link for the last chart pulled."
                      "type"        = "string"
                    }
                  }
                  "type" = "object"
                }
              }
              "type" = "object"
            }
          }
          "served"  = true
          "storage" = true
          "subresources" = {
            "status" = {}
          }
        },
      ]
    }
  }
}
