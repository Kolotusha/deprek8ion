package main

warn[msg] {
  input.apiVersion == "v1"
  input.kind == "List"
  obj := input.items[_]
  msg := _warn with input as obj
}

warn[msg] {
  input.apiVersion != "v1"
  input.kind != "List"
  msg := _warn
}

# new rules for 1.23

_warn = msg {
  resources := ["FlowSchema", "PriorityLevelConfiguration", "Role"]
  input.apiVersion == "flowcontrol.apiserver.k8s.io/v1beta1"
  input.kind == resources[_]
  msg := sprintf("%s/%s: The flowcontrol.apiserver.k8s.io/v1beta1 API version of FlowSchema and PriorityLevelConfiguration will no longer be served in v1.26. Migrate manifests and API clients to use the flowcontrol.apiserver.k8s.io/v1beta2 API version, available since v1.23.", [input.kind, input.metadata.name, input.kind])
}

_warn = msg {
  apis := ["autoscaling/v2beta1", "autoscaling/v2beta2"]
  input.apiVersion == apis[_]
  input.kind == "HorizontalPodAutoscaler"
  msg := sprintf("%s/%s: The autoscaling/v2beta1 API version of HorizontalPodAutoscaler will no longer be served in v1.25. Migrate manifests and API clients to use the autoscaling/v2 API version, available since v1.23.", [input.kind, input.metadata.name])
}





