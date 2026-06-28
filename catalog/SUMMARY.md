# Catalog summary

One row per gate. Lists what evidence the gate produces, which controls in each framework it satisfies, and where the example lives. Use this when you want to decide which gates apply to your audit obligation before reading the per-framework guides.

A trailing `*` on a control ID means the mapping is **BEST-FIT** — the control was not designed for what the gate produces, but the evidence shape works. Most AI-DLC mappings are best-fit because none of SOC 2, ISO 27001, PCI 4.0, or HIPAA was written with generative AI in mind. See [`../docs/ai-dlc-extension.md`](../docs/ai-dlc-extension.md) for why and the emerging frameworks (ISO 42001, NIST AI RMF) where the fit is cleaner.

For each gate's full description, evidence shapes, tooling examples, and failure mode, see [`gates.yaml`](gates.yaml). For the full mapping notes, see [`mappings.yaml`](mappings.yaml).

| Lifecycle | Gate | Evidence | SOC 2 | ISO 27001 | PCI 4.0 | HIPAA | Example |
|---|---|---|---|---|---|---|---|
| PDLC | `build-decision-recorded` | Recorded ticket / RFC with named approver | CC2.1, CC3.1, CC8.1 | A.5.8 | 12.3 | §164.308(a)(1)(ii)(A) | [PR template](../examples/pr-templates/) |
| PDLC | `risk-review-attached` | Security or privacy review linked to the build decision | CC3.2, CC3.4, CC9.1 | A.5.8, A.8.25, A.8.27 | 6.1.2, 12.3 | §164.308(a)(1)(ii)(A), (B) | [PR template](../examples/pr-templates/) |
| PDLC | `post-launch-feedback` | Post-launch review record with metrics | CC4.1, CC9.1 | A.5.24, A.8.16 | 11.5 | §164.308(a)(1)(ii)(D) | — |
| SDLC | `change-reviewed` | Non-author PR / MR approval record | CC8.1, CC2.1 | A.8.32, A.8.28, A.5.3 | 6.2.3, 6.5.1 | §164.308(a)(1)(ii)(B), (a)(4) | [PR template](../examples/pr-templates/) |
| SDLC | `tests-passed` | Green CI run with test result artifact | CC8.1, CC7.1 | A.8.29, A.8.32 | 6.3.1, 6.5.2, 11.4 | §164.308(a)(8) | [GitHub Actions](../examples/github-actions/) |
| SDLC | `policy-passed` | Policy gate pass / fail (Conftest, Trivy, etc.) | CC5.3, CC7.1, CC8.1 | A.5.36, A.8.29 | 6.3.3, 6.4.1 | §164.308(a)(8), §164.312(c)(1) | [Conftest](../examples/conftest/), [GitHub Actions](../examples/github-actions/) |
| SDLC | `deploy-authorized` | Signed deploy with provenance attestation | CC6.1, CC8.1 | A.8.32, A.5.3, A.8.31 | 6.5.1, 6.5.4 | §164.308(a)(3), §164.312(a)(1) | [GitHub Actions](../examples/github-actions/), [OSCAL](../examples/oscal/) |
| SDLC | `deploy-logged` | Append-only deploy log (commit, image, time, deployer) | CC7.1, CC7.2 | A.8.15, A.8.16 | 10.2, 10.3 | §164.312(b), §164.308(a)(1)(ii)(D) | [GitHub Actions](../examples/github-actions/) |
| SDLC | `author-training-current` | Author has current security training (LMS record) | CC1.4, CC2.2 | A.6.3, A.5.36 | 6.2.2, 12.6 | §164.308(a)(5) | [PR template](../examples/pr-templates/) |
| SDLC | `source-access-restricted` | Repo access list audited periodically | CC6.1, CC6.3 | A.8.4, A.8.2, A.5.18 | 7.2.1, 7.2.4, 7.3.1 | §164.308(a)(4), §164.312(a)(1) | — |
| SDLC | `test-data-clean` | No production data in pre-prod; test accounts removed at release | CC6.7, CC8.1 | A.8.33, A.8.31 | 6.5.5, 6.5.6 | §164.308(a)(4), §164.312(c)(1) | [PR template](../examples/pr-templates/) |
| SDLC | `dependency-provenance` | SBOM attached, dependencies pinned and verified | CC7.1, CC8.1 | A.5.21, A.8.30, A.8.28 | 6.3.2, 6.3.3 | §164.308(a)(8), §164.308(a)(1)(ii)(D) | [GitHub Actions](../examples/github-actions/) |
| AI-DLC | `ai-eval-cleared` | Eval report with pinned threshold and eval-set hash | CC8.1\*, CC3.2\* | A.8.29\*, A.8.33\* | 6.3.1\* | §164.308(a)(8)\* | [PR template](../examples/pr-templates/) |
| AI-DLC | `ai-adversarial-test` | Adversarial test report with attack types and pass rate | CC7.1\*, CC8.1\* | A.8.29\*, A.5.7\* | 11.4\* | §164.308(a)(8)\* | [PR template](../examples/pr-templates/) |
| AI-DLC | `ai-human-signoff` | Named individual sign-off with role, scope, date | CC1.5, CC2.1 | A.5.3, A.5.4 | 12.4\*, 6.5.1 | §164.308(a)(2) | [PR template](../examples/pr-templates/) |
| AI-DLC | `ai-drift-monitor` | Live eval dashboard + alert routing + rollback runbook | CC7.1\*, CC7.2\*, CC7.3\* | A.8.16, A.5.24\* | 11.5\* | §164.308(a)(1)(ii)(D), (a)(6) | — |

## How to read this table

- **Lifecycle** is which of the three the gate belongs to. AI-DLC gates only apply when an AI agent or model is in scope; the other 8 gates apply to every release.
- **Evidence** is the artifact the auditor reads. The gate is real if and only if this artifact is produced as a byproduct of the work.
- **Framework columns** list every control the gate produces evidence for. An empty cell means the gate has no defensible mapping in that framework.
- **Example** is the file in this repo that shows how to implement the gate. `—` means there is no example file yet — open a PR if you have one.

## Quick lookups

- "Which gates do I need for **SOC 2**?" → All sixteen, by typical SOC 2 scope. The SDLC nine are non-optional; `author-training-current` is the one teams most often miss.
- "Which gates do I need for **PCI DSS 4.0**?" → All SDLC gates plus `risk-review-attached`. `author-training-current`, `test-data-clean`, and `dependency-provenance` map to specific PCI 4.0 requirements (6.2.2, 6.5.5/6, 6.3.2/3) that PCI 4.0 added or sharpened relative to 3.2.1. AI-DLC gates only if card data flows through an AI agent.
- "Which gates do I need for **HIPAA**?" → All SDLC gates plus `risk-review-attached` and `post-launch-feedback`. `author-training-current` carries §164.308(a)(5), which OCR investigations frequently cite. AI-DLC gates only if AI touches ePHI.
- "Which gates do I need for **ISO 27001**?" → All sixteen. `source-access-restricted` maps directly to A.8.4 (one of the new 2022 controls); `dependency-provenance` maps to A.5.21 supply-chain control; `policy-passed` and `change-reviewed` still carry most of the change-management evidence.
