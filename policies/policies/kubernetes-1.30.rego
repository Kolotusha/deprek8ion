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

# new rules for 1.30

_deny = msg {
  resources := ["FlowSchema", "PriorityLevelConfiguration"]
  input.apiVersion == "flowcontrol.apiserver.k8s.io/v1beta2"
  input.kind == resources[_]
  msg := sprintf("%s/%s: The flowcontrol.apiserver.k8s.io/v1beta1 API version of FlowSchema and PriorityLevelConfiguration is no longer served as of v1.29. flowcontrol.apiserver.k8s.io/v1 API version, available since v1.29.", [input.kind, input.metadata.name, input.kind])
}
