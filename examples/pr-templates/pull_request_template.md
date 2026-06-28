<!--
Save as .github/pull_request_template.md in your repo.

This template captures the evidence the change-reviewed and (when applicable)
risk-review-attached gates expect. The reviewer answering these fields is
what the auditor sees.
-->

## What this changes

<!-- One paragraph. The reviewer should be able to evaluate scope from this. -->

## Linked build decision

<!-- Link to the ticket / RFC / design doc that authorized this work. -->
<!-- Required for non-trivial changes. Mark "n/a — trivial" for typo fixes etc. -->

Decision: <!-- linear-1234 / rfc-99 / n/a -->

## Risk surfaces touched

- [ ] None — pure refactor or doc change
- [ ] Authentication / authorization
- [ ] Encryption or key handling
- [ ] PII / PHI / cardholder data
- [ ] Public-facing surface (new endpoint, new third-party integration)
- [ ] AI / agent behavior change
- [ ] Trust boundary (new tenant separation, new sandbox, new privilege)

If any box above is checked, link the security or privacy review:

Review: <!-- security-review-123 / dpia-45 / n/a -->

## Gate evidence

<!-- Reviewer confirms — these are checks against the catalog gates. -->

- [ ] CI run is green (`tests-passed`)
- [ ] Policy / security scans are green (`policy-passed`)
- [ ] Author has current security training within the policy window (`author-training-current`)
- [ ] SBOM is attached and dependencies are pinned (`dependency-provenance`)
- [ ] If pre-prod data was needed, it is synthetic or scrubbed and test accounts are removed (`test-data-clean`)
- [ ] For AI changes: eval ran against the held-out set and cleared threshold (`ai-eval-cleared`)
- [ ] For AI changes: adversarial / guardrail test passed (`ai-adversarial-test`)
- [ ] For AI changes: I, named here, take responsibility for behavior (`ai-human-signoff`)

## Out of scope

<!-- What this change deliberately does NOT do, so the reviewer doesn't expect it. -->
