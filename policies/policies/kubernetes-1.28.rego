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

# new rules for 1.27

_deny = msg {
  input.apiVersion == "storage.k8s.io/v1beta1"
  input.kind == "CSIStorageCapacity"
 msg := sprintf("%s/%s: The storage.k8s.io/v1beta1 API version of CSIStorageCapacity will no longer be served in v1.27.", [input.kind, input.metadata.name])
}
