# Example Conftest policy enforcing the `policy-passed` gate on Kubernetes manifests.
#
# Run with:
#   conftest test --policy policy.rego deployment.yaml
#
# This is a minimal starter. Real policies grow to cover image provenance,
# resource limits, network policies, allowed registries, secret mounts, etc.

package main

import future.keywords.contains
import future.keywords.if
import future.keywords.in

# Deny containers running as root.
deny contains msg if {
	input.kind == "Deployment"
	some container in input.spec.template.spec.containers
	not container.securityContext.runAsNonRoot
	msg := sprintf("Container %q must set securityContext.runAsNonRoot=true", [container.name])
}

# Deny images without an explicit tag (the implicit `latest` is non-deterministic).
deny contains msg if {
	input.kind == "Deployment"
	some container in input.spec.template.spec.containers
	not contains(container.image, "@sha256:")
	not contains(container.image, ":")
	msg := sprintf("Container %q image %q must be tagged or digest-pinned", [container.name, container.image])
}

# Deny pulling from registries outside the allow-list.
allowed_registries := [
	"ghcr.io/your-org/",
	"your-registry.example.com/",
]

deny contains msg if {
	input.kind == "Deployment"
	some container in input.spec.template.spec.containers
	not registry_allowed(container.image)
	msg := sprintf("Container %q image %q is not from an allowed registry %v", [container.name, container.image, allowed_registries])
}

registry_allowed(image) if {
	some registry in allowed_registries
	startswith(image, registry)
}

# Deny missing resource limits (catch noisy-neighbor / OOM patterns at the gate).
deny contains msg if {
	input.kind == "Deployment"
	some container in input.spec.template.spec.containers
	not container.resources.limits.memory
	msg := sprintf("Container %q must set resources.limits.memory", [container.name])
}
