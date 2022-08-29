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

# new rules for 1.25

_deny = msg {
  input.apiVersion == "batch/v1beta1"
  input.kind == "CronJob"
 msg := sprintf("%s/%s: The batch/v1beta1 API version of CronJob will no longer be served in v1.25. Migrate manifests and API clients to use the batch/v1 API version, available since v1.21.", [input.kind, input.metadata.name])
}

_deny = msg {
  input.apiVersion == "discovery.k8s.io/v1beta1"
  input.kind == "EndpointSlice"
 msg := sprintf("%s/%s: The discovery.k8s.io/v1beta1 API version of EndpointSlice will no longer be served in v1.25. Migrate manifests and API clients to use the discovery.k8s.io/v1 API version, available since v1.21", [input.kind, input.metadata.name])
}

_deny = msg {
  input.apiVersion == "events.k8s.io/v1beta1"
  input.kind == "Event"
 msg := sprintf("%s/%s: The events.k8s.io/v1beta1 API version of Event will no longer be served in v1.25. Migrate manifests and API clients to use the events.k8s.io/v1 API version, available since v1.19", [input.kind, input.metadata.name])
}

_deny = msg {
  input.apiVersion == "autoscaling/v2beta1"
  input.kind == "HorizontalPodAutoscaler"
 msg := sprintf("%s/%s: The autoscaling/v2beta1 API version of HorizontalPodAutoscaler will no longer be served in v1.25. Migrate manifests and API clients to use the autoscaling/v2 API version, available since v1.23 ", [input.kind, input.metadata.name])
}

_deny = msg {
  input.apiVersion == "policy/v1beta1"
  input.kind == "PodDisruptionBudget"
 msg := sprintf("%s/%s: The policy/v1beta1 API version of PodDisruptionBudget will no longer be served in v1.25. Migrate manifests and API clients to use the policy/v1 API version, available since v1.21 ", [input.kind, input.metadata.name])
}

_deny = msg {
  input.apiVersion == "policy/v1beta1"
  input.kind == "PodSecurityPolicy"
 msg := sprintf("%s/%s: PodSecurityPolicy in the policy/v1beta1 API version will no longer be served in v1.25, and the PodSecurityPolicy admission controller will be removed. ", [input.kind, input.metadata.name])
}

_deny = msg {
  input.apiVersion == "node.k8s.io/v1beta1"
  input.kind == "RuntimeClass"
 msg := sprintf("%s/%s: RuntimeClass in the node.k8s.io/v1beta1 API version will no longer be served in v1.25. Migrate manifests and API clients to use the node.k8s.io/v1 API version, available since v1.20 ", [input.kind, input.metadata.name])
}
