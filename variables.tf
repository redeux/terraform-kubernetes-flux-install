variable "namespace" {
    type = string
    default = "flux-system"
}

variable "flux_version" {
    type = string
    default = "v0.9.0"
}

variable "cluster_domain" {
    type = string
    default = "cluster.local"
}

variable "registry" {
    type = string
    default = "ghcr.io/fluxcd"
}

variable "log_level" {
    type = string
    default = "info"
    description = "debug, info, error"
}

variable "watch_all_namespaces" {
  type = bool
  default = true
}

variable "source_controller" {
    type = bool
    default = true
}

variable "kustomize_controller" {
    type = bool
    default = true
}

variable "helm_controller" {
    type = bool
    default = true
}

variable "notification_controller" {
    type = bool
    default = true
}