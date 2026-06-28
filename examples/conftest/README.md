# Example: Conftest at the policy-passed gate

This directory holds a working starter policy for the `policy-passed` gate. The policy runs against Kubernetes manifests and enforces a small set of org-typical rules: no root containers, no implicit `latest` tags, only approved registries, required resource limits.

## What this satisfies

- `policy-passed` from `catalog/gates.yaml`
- SOC 2 CC5.3, CC7.1, CC8.1
- ISO 27001 A.5.36, A.8.29
- PCI DSS 4.0 6.3.3, 6.4.1
- HIPAA §164.308(a)(8), §164.312(c)(1)

See `frameworks/*.md` for the full mapping.

## Run locally

```bash
brew install conftest                 # or: go install github.com/open-policy-agent/conftest
conftest test --policy policy.rego your-deployment.yaml
```

Exit code is non-zero when any `deny` rule fires. Wire that into your CI as a required status check and the evidence is automatic: a green check means the policy ran on this change.

## What's missing on purpose

- Image provenance verification (use Sigstore Cosign — see `deploy-authorized` gate)
- Vulnerability scanning (use Trivy or similar — separate gate)
- Network policy enforcement (use Kyverno or OPA Gatekeeper as an admission controller)
- Secret leakage detection (use Gitleaks / TruffleHog at the change-reviewed or tests-passed gate)

The point of this example is the shape of the gate. Real policies grow.
