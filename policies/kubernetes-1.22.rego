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

#from 1.16 -
# All resources under apps/v1beta1 and apps/v1beta2 - use apps/v1 instead
_deny = msg {
  apis := ["apps/v1beta1", "apps/v1beta2"]
  input.apiVersion == apis[_]
  msg := sprintf("%s/%s: API %s has been deprecated, use apps/v1 instead.", [input.kind, input.metadata.name, input.apiVersion])
}

# daemonsets, deployments, replicasets resources under extensions/v1beta1 - use apps/v1 instead
_deny = msg {
  resources := ["DaemonSet", "Deployment", "ReplicaSet"]
  input.apiVersion == "extensions/v1beta1"
  input.kind == resources[_]
  msg := sprintf("%s/%s: API extensions/v1beta1 for %s has been deprecated, use apps/v1 instead.", [input.kind, input.metadata.name, input.kind])
}

# networkpolicies resources under extensions/v1beta1 - use networking.k8s.io/v1 instead
_deny = msg {
  input.apiVersion == "extensions/v1beta1"
  input.kind == "NetworkPolicy"
  msg := sprintf("%s/%s: API extensions/v1beta1 for NetworkPolicy has been deprecated, use networking.k8s.io/v1 instead.", [input.kind, input.metadata.name])
}

# podsecuritypolicies resources under extensions/v1beta1 - use policy/v1beta1 instead
_deny = msg {
  input.apiVersion == "extensions/v1beta1"
  input.kind == "PodSecurityPolicy"
  msg := sprintf("%s/%s: API extensions/v1beta1 for PodSecurityPolicy has been deprecated, use policy/v1beta1 instead.", [input.kind, input.metadata.name])
}

# from 1.17
# Based on https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.16.md

# PriorityClass resources will no longer be served from scheduling.k8s.io/v1beta1 and scheduling.k8s.io/v1alpha1 in v1.17.
_deny = msg {
  apis := ["scheduling.k8s.io/v1beta1", "scheduling.k8s.io/v1alpha1"]
  input.apiVersion == apis[_]
  input.kind == "PriorityClass"
  msg := sprintf("%s/%s: API %s for PriorityClass has been deprecated, use scheduling.k8s.io/v1 instead.", [input.kind, input.metadata.name, input.apiVersion])
}

# from 1.18

# Based on https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.18.md

# Within Ingress resources spec.ingressClassName replaces the deprecated kubernetes.io/ingress.class annotation.
_deny = msg {
  resources := ["Ingress"]
  input.kind == resources[_]
  input.metadata.annotations["kubernetes.io/ingress.class"]
  msg := sprintf("%s/%s: Ingress annotation kubernetes.io/ingress.class has been deprecated in 1.18, use spec.IngressClassName instead.", [input.kind, input.metadata.name])
}

# from 1.19

# Based on https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.19.md

# The apiextensions.k8s.io/v1beta1 version of CustomResourceDefinition is deprecated in 1.19. Migrate to use apiextensions.k8s.io/v1 instead
_deny = msg {
  input.apiVersion == "apiextensions.k8s.io/v1beta1"
  input.kind == "CustomResourceDefinition"
 msg := sprintf("%s/%s: API apiextensions.k8s.io/v1beta1 for CustomResourceDefinition is deprecated in 1.19, use apiextensions.k8s.io/v1 instead.", [input.kind, input.metadata.name])
}

# The apiregistration.k8s.io/v1beta1 version is deprecated in 1.19. Migrate to use apiregistration.k8s.io/v1 instead
_deny = msg {
  input.apiVersion == "apiregistration.k8s.io/v1beta1"
  msg := sprintf("%s/%s: API apiregistration.k8s.io/v1beta1 is deprecated in Kubernetes 1.19, use apiregistration.k8s.io/v1 instead.", [input.kind, input.metadata.name])
}

# The authentication.k8s.io/v1beta1 version is deprecated in 1.19. Migrate to use authentication.k8s.io/v1 instead
_deny = msg {
  input.apiVersion == "authentication.k8s.io/v1beta1"
  msg := sprintf("%s/%s: API authentication.k8s.io/v1beta1 is deprecated in Kubernetes 1.19, use authentication.k8s.io/v1 instead.", [input.kind, input.metadata.name])
}

# The authorization.k8s.io/v1beta1 version is deprecated in 1.19. Migrate to use authorization.k8s.io/v1 instead
_deny = msg {
  input.apiVersion == "authorization.k8s.io/v1beta1"
  msg := sprintf("%s/%s: API authorization.k8s.io/v1beta1 is deprecated in Kubernetes 1.19, use authorization.k8s.io/v1 instead.", [input.kind, input.metadata.name])
}

# The autoscaling/v2beta1 version is deprecated in 1.19. Migrate to use autoscaling/v2beta2 instead
_deny = msg {
  input.apiVersion == "autoscaling/v2beta1"
  msg := sprintf("%s/%s: API autoscaling/v2beta1 is deprecated in Kubernetes 1.19, use autoscaling/v2beta2 instead.", [input.kind, input.metadata.name])
}

# The coordination.k8s.io/v1beta1 version is deprecated in 1.19. Migrate to use coordination.k8s.io/v1 instead
_deny = msg {
  input.apiVersion == "coordination.k8s.io/v1beta1"
  msg := sprintf("%s/%s: API coordination.k8s.io/v1beta1 is deprecated in Kubernetes 1.19, use coordination.k8s.io/v1 instead.", [input.kind, input.metadata.name])
}

# The storage.k8s.io/v1beta1 version is deprecated in 1.19. Migrate to use storage.k8s.io/v1 instead
_deny = msg {
  input.apiVersion == "storage.k8s.io/v1beta1"
  msg := sprintf("%s/%s: API storage.k8s.io/v1beta1 is deprecated in Kubernetes 1.19, use storage.k8s.io/v1 instead.", [input.kind, input.metadata.name])
}

# from 1.20

# All resources will no longer be served from rbac.authorization.k8s.io/v1alpha1 and rbac.authorization.k8s.io/v1beta1 in 1.20. Migrate to use rbac.authorization.k8s.io/v1 instead
_deny = msg {
  apis := ["rbac.authorization.k8s.io/v1alpha1", "rbac.authorization.k8s.io/v1beta1"]
  input.apiVersion == apis[_]
  msg := sprintf("%s/%s: API %s is deprecated from Kubernetes 1.20, use rbac.authorization.k8s.io/v1 instead.", [input.kind, input.metadata.name, input.apiVersion])
}


# from 1.22
# Based on https://github.com/kubernetes/kubernetes/issues/82021

# The admissionregistration.k8s.io/v1beta1 versions of MutatingWebhookConfiguration and ValidatingWebhookConfiguration are deprecated in 1.19. Migrate to use admissionregistration.k8s.io/v1 instead
_deny = msg {
  kinds := ["MutatingWebhookConfiguration", "ValidatingWebhookConfiguration"]
  input.apiVersion == "admissionregistration.k8s.io/v1beta1"
  input.kind == kinds[_]
  msg := sprintf("%s/%s: API admissionregistration.k8s.io/v1beta1 is deprecated in Kubernetes 1.22, use admissionregistration.k8s.io/v1 instead.", [input.kind, input.metadata.name])
}

# Based on https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-25

_deny = msg {
  apis := ["extensions/v1beta1", "networking.k8s.io/v1beta1"]
  input.apiVersion == apis[_]
  input.kind == "Ingress"
  msg := sprintf("%s/%s: Migrate manifests and API clients to use the networking.k8s.io/v1 API version, available since v1.19.", [input.kind, input.metadata.name, input.apiVersion])
}

_deny = msg {
  input.apiVersion == "networking.k8s.io/v1beta1"
  input.kind == "IngressClass"
  msg := sprintf("%s/%s: Migrate manifests and API clients to use the networking.k8s.io/v1 API version, available since v1.19.", [input.kind, input.metadata.name])
}

_deny = msg {
  resources := ["ClusterRole", "ClusterRoleBinding", "Role" ,"RoleBinding "]
  input.apiVersion == "rbac.authorization.k8s.io/v1beta1"
  input.kind == resources[_]
  msg := sprintf("%s/%s: Migrate manifests and API clients to use the rbac.authorization.k8s.io/v1 API version, available since v1.8.", [input.kind, input.metadata.name, input.kind])
}

_deny = msg {
  input.apiVersion == "certificates.k8s.io/v1beta1"
  input.kind == "CertificateSigningRequest"
  msg := sprintf("%s/%s: The certificates.k8s.io/v1beta1 API version of CertificateSigningRequest is no longer served as of v1.22. Migrate manifests and API clients to use the certificates.k8s.io/v1 API version, available since v1.19.", [input.kind, input.metadata.name])
}



