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

# new rules for 1.24

_warn = msg {
  input.apiVersion == "apiextensions.k8s.io/v1beta1"
  input.kind == "CSIStorageCapacity"
 msg := sprintf("%s/%s: he storage.k8s.io/v1beta1 API version of CSIStorageCapacity will no longer be served in v1.27. use storage.k8s.io/v1 API version instead.", [input.kind, input.metadata.name])
}
