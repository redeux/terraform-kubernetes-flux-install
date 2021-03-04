resource "kubernetes_manifest" "customresourcedefinition_buckets_source_toolkit_fluxcd_io" {
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
      "name" = "buckets.source.toolkit.fluxcd.io"
    }
    "spec" = {
      "group" = "source.toolkit.fluxcd.io"
      "names" = {
        "kind"     = "Bucket"
        "listKind" = "BucketList"
        "plural"   = "buckets"
        "singular" = "bucket"
      }
      "scope" = "Namespaced"
      "versions" = [
        {
          "additionalPrinterColumns" = [
            {
              "jsonPath" = ".spec.url"
              "name"     = "URL"
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
              "description" = "Bucket is the Schema for the buckets API"
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
                  "description" = "BucketSpec defines the desired state of an S3 compatible bucket"
                  "properties" = {
                    "bucketName" = {
                      "description" = "The bucket name."
                      "type"        = "string"
                    }
                    "endpoint" = {
                      "description" = "The bucket endpoint address."
                      "type"        = "string"
                    }
                    "ignore" = {
                      "description" = "Ignore overrides the set of excluded patterns in the .sourceignore format (which is the same as .gitignore). If not provided, a default will be used, consult the documentation for your version to find out what those are."
                      "type"        = "string"
                    }
                    "insecure" = {
                      "description" = "Insecure allows connecting to a non-TLS S3 HTTP endpoint."
                      "type"        = "boolean"
                    }
                    "interval" = {
                      "description" = "The interval at which to check for bucket updates."
                      "type"        = "string"
                    }
                    "provider" = {
                      "default"     = "generic"
                      "description" = "The S3 compatible storage provider name, default ('generic')."
                      "enum" = [
                        "generic",
                        "aws",
                      ]
                      "type" = "string"
                    }
                    "region" = {
                      "description" = "The bucket region."
                      "type"        = "string"
                    }
                    "secretRef" = {
                      "description" = "The name of the secret containing authentication credentials for the Bucket."
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
                    "suspend" = {
                      "description" = "This flag tells the controller to suspend the reconciliation of this source."
                      "type"        = "boolean"
                    }
                    "timeout" = {
                      "default"     = "20s"
                      "description" = "The timeout for download operations, defaults to 20s."
                      "type"        = "string"
                    }
                  }
                  "required" = [
                    "bucketName",
                    "endpoint",
                    "interval",
                  ]
                  "type" = "object"
                }
                "status" = {
                  "description" = "BucketStatus defines the observed state of a bucket"
                  "properties" = {
                    "artifact" = {
                      "description" = "Artifact represents the output of the last successful Bucket sync."
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
                      "description" = "Conditions holds the conditions for the Bucket."
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
                      "description" = "URL is the download link for the artifact output of the last Bucket sync."
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
