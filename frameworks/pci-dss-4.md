# PCI DSS 4.0

This file shows which PCI DSS 4.0 requirements the gate catalog produces evidence for, and how the evidence satisfies the requirement.

PCI DSS 4.0 was published in March 2022 with most controls effective March 2025. The catalog focuses on Requirement 6 (develop and maintain secure systems and software), Requirement 10 (log and monitor access), Requirement 11 (test security), and Requirement 12 (support information security with org policies). PCI DSS controls outside the SDLC (network segmentation, encryption, key management, anti-malware, physical security) are not covered.

## Quick reference: requirement to gate

| Req | Requirement | Gates that produce evidence |
|---|---|---|
| **6.1.2** | Roles and responsibilities for secure development are documented | `risk-review-attached` |
| **6.2.3** | Bespoke and custom software is reviewed prior to release | `change-reviewed` |
| **6.3.1** | Security vulnerabilities are identified and ranked | `tests-passed`, `ai-eval-cleared` (best-fit) |
| **6.3.3** | System components are protected from known vulnerabilities | `policy-passed` |
| **6.4.1** | Public-facing web applications are protected against attacks | `policy-passed` |
| **6.5.1** | Changes to all system components are managed | `change-reviewed`, `deploy-authorized`, `ai-human-signoff` |
| **6.5.2** | Changes are confirmed and validated against PCI requirements | `tests-passed` |
| **6.5.4** | Roles and functions are separated between production and pre-production | `deploy-authorized` |
| **10.2** | Audit logs are implemented to support detection and forensics | `deploy-logged` |
| **10.3** | Audit logs are protected from destruction and unauthorized modification | `deploy-logged` (when append-only) |
| **11.4** | External and internal penetration testing performed | `ai-adversarial-test` (partial) |
| **11.5** | Detection of unexpected changes or anomalies | `post-launch-feedback`, `ai-drift-monitor` (best-fit) |
| **12.3** | Risks to the CDE are formally identified, evaluated, managed | `build-decision-recorded`, `risk-review-attached` |
| **12.4** | Roles and responsibilities for protecting the CDE are documented | `ai-human-signoff` (best-fit) |

## How a QSA uses this

PCI assessors (QSAs) test each requirement against the same evidence shape: documented procedure, plus evidence of operation over the sampling window.

- **6.2.3 (review before release):** for a sample of changes, the QSA wants to see the review record showing a non-author approved before release. `change-reviewed` produces this directly. The QSA will typically sample across in-scope repositories.
- **6.3.3 (protection from known vulnerabilities):** the QSA wants evidence that vulnerable components are caught and remediated. `policy-passed` outputs (Trivy, Checkov, dependency-scanner results) are direct evidence; the remediation thread is separate.
- **6.5.1 (managed changes):** for a sample of changes in scope, show the full chain: ticket → review → tests → policy check → signed deploy → log entry. The catalog produces every link.
- **10.2 / 10.3 (audit logs):** the deploy log must be append-only and protected. The `deploy-logged` gate specifies this; the implementation needs to match.
- **11.4 (penetration testing):** the catalog only partially covers this through `ai-adversarial-test`. Traditional pen testing is a separate engagement and not produced by the SDLC.

## What this catalog does NOT cover

PCI DSS 4.0 has 12 requirements; this catalog touches parts of 4. It does not produce evidence for:

- **Req 1, 2:** network security, system configuration
- **Req 3:** cardholder data protection (encryption at rest, masking, retention)
- **Req 4:** strong cryptography for transmission
- **Req 5:** anti-malware
- **Req 7:** access restrictions by need-to-know
- **Req 8:** identification and authentication
- **Req 9:** physical access
- **Req 10:** parts beyond deploy-logging (user activity logs, log review processes, time sync)
- **Req 11:** vulnerability scanning, IDS/IPS, file integrity, payment-page integrity monitoring
- **Req 12:** parts beyond risk assessment and the AI-related sign-off

You need a broader compliance program for those. This catalog is a tool inside the program, not a substitute.

## Notes for AI-DLC mappings

PCI DSS 4.0 does not mention AI. The AI-DLC gates are best-fit to the closest existing requirements:

- `ai-eval-cleared` → 6.3.1 (vulnerability identification, weak fit — a failed eval is an identified quality risk)
- `ai-adversarial-test` → 11.4 (penetration testing, partial fit — adversarial testing is structurally similar)
- `ai-human-signoff` → 12.4 (roles and responsibilities) + 6.5.1 (managed changes)
- `ai-drift-monitor` → 11.5 (unexpected change detection)

If you process card data through an AI agent, treat the agent as in-scope for PCI and use the AI-DLC gates as additive evidence. See `docs/ai-dlc-extension.md`.

## References

- [PCI DSS v4.0 (PCI Security Standards Council)](https://www.pcisecuritystandards.org/document_library?category=pcidss)
- [PCI DSS 4.0 Summary of Changes](https://docs-prv.pcisecuritystandards.org/PCI%20DSS/Standard/PCI-DSS-v3-2-1-to-v4-0-Summary-of-Changes-r2.pdf)
