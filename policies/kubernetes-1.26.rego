package main

deny[msg] {
  input.apiVersion == "v1"
  input.kind == "List"
  obj := input.items[_]
  msg := _deny with input as obj
}

deny[msg] {
  input.apiVersion != "v1"
  input.kind != "List"
  msg := _deny
}

# new rules for 1.26

_deny = msg {
  input.apiVersion == "autoscaling/v2beta2"
  input.kind == "HorizontalPodAutoscale"
 msg := sprintf("%s/%s: The autoscaling/v2beta2 API version of HorizontalPodAutoscaler is no longer served as of v1.26. Migrate manifests and API clients to use the autoscaling/v2 API version.", [input.kind, input.metadata.name])
}

_deny = msg {
  resources := ["FlowSchema", "PriorityLevelConfiguration"]
  input.apiVersion == "flowcontrol.apiserver.k8s.io/v1beta1"
  input.kind == resources[_]
  msg := sprintf("%s/%s: The flowcontrol.apiserver.k8s.io/v1beta1 API version of FlowSchema and PriorityLevelConfiguration is no longer served as of v1.26. Migrate manifests and API clients to use the flowcontrol.apiserver.k8s.io/v1beta3 API version, available since v1.26.", [input.kind, input.metadata.name, input.kind])
}
