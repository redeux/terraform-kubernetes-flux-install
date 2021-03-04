resource "kubernetes_manifest" "customresourcedefinition_alerts_notification_toolkit_fluxcd_io" {
  provider = kubernetes-alpha

  manifest = {
    "apiVersion" = "apiextensions.k8s.io/v1"
    "kind"       = "CustomResourceDefinition"
    "metadata" = {
      "annotations" = {
        "controller-gen.kubebuilder.io/version" = "v0.4.1"
      }
      "labels" = {
        "app.kubernetes.io/instance" = kubernetes_manifest.namespace_flux_system.object.metadata.name
        "app.kubernetes.io/version"  = var.flux_version
      }
      "name" = "alerts.notification.toolkit.fluxcd.io"
    }
    "spec" = {
      "group" = "notification.toolkit.fluxcd.io"
      "names" = {
        "kind"     = "Alert"
        "listKind" = "AlertList"
        "plural"   = "alerts"
        "singular" = "alert"
      }
      "scope" = "Namespaced"
      "versions" = [
        {
          "additionalPrinterColumns" = [
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
              "description" = "Alert is the Schema for the alerts API"
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
                  "description" = "AlertSpec defines an alerting rule for events involving a list of objects"
                  "properties" = {
                    "eventSeverity" = {
                      "default"     = "info"
                      "description" = "Filter events based on severity, defaults to ('info'). If set to 'info' no events will be filtered."
                      "enum" = [
                        "info",
                        "error",
                      ]
                      "type" = "string"
                    }
                    "eventSources" = {
                      "description" = "Filter events based on the involved objects."
                      "items" = {
                        "description" = "CrossNamespaceObjectReference contains enough information to let you locate the typed referenced object at cluster level"
                        "properties" = {
                          "apiVersion" = {
                            "description" = "API version of the referent"
                            "type"        = "string"
                          }
                          "kind" = {
                            "description" = "Kind of the referent"
                            "enum" = [
                              "Bucket",
                              "GitRepository",
                              "Kustomization",
                              "HelmRelease",
                              "HelmChart",
                              "HelmRepository",
                              "ImageRepository",
                              "ImagePolicy",
                              "ImageUpdateAutomation",
                            ]
                            "type" = "string"
                          }
                          "name" = {
                            "description" = "Name of the referent"
                            "maxLength"   = 53
                            "minLength"   = 1
                            "type"        = "string"
                          }
                          "namespace" = {
                            "description" = "Namespace of the referent"
                            "maxLength"   = 53
                            "minLength"   = 1
                            "type"        = "string"
                          }
                        }
                        "required" = [
                          "name",
                        ]
                        "type" = "object"
                      }
                      "type" = "array"
                    }
                    "exclusionList" = {
                      "description" = "A list of Golang regular expressions to be used for excluding messages."
                      "items" = {
                        "type" = "string"
                      }
                      "type" = "array"
                    }
                    "providerRef" = {
                      "description" = "Send events using this provider."
                      "properties" = {
                        "name" = {
                          "description" = "Name of the referent"
                          "type"        = "string"
                        }
                      }
                      "required" = [
                        "name",
                      ]
                      "type" = "object"
                    }
                    "summary" = {
                      "description" = "Short description of the impact and affected cluster."
                      "type"        = "string"
                    }
                    "suspend" = {
                      "description" = "This flag tells the controller to suspend subsequent events dispatching. Defaults to false."
                      "type"        = "boolean"
                    }
                  }
                  "required" = [
                    "eventSources",
                    "providerRef",
                  ]
                  "type" = "object"
                }
                "status" = {
                  "description" = "AlertStatus defines the observed state of Alert"
                  "properties" = {
                    "conditions" = {
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
