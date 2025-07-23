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

# Deprecated in Kubernetes v1.32
_warn = msg {
  resources := ["FlowSchema", "PriorityLevelConfiguration"]
  input.apiVersion == "flowcontrol.apiserver.k8s.io/v1beta3"
  input.kind == resources[_]
  msg := sprintf(
    "%s/%s: The API version flowcontrol.apiserver.k8s.io/v1beta3 is removed in Kubernetes v1.32. Please migrate to flowcontrol.apiserver.k8s.io/v1.",
    [input.kind, input.metadata.name]
  )
}
