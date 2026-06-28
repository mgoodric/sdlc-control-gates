# SOC 2 (Trust Services Criteria 2017)

This file shows which SOC 2 common criteria the gate catalog produces evidence for, and how the evidence satisfies the criterion.

SOC 2 is principle-based: the AICPA Trust Services Criteria name what the auditor wants to see, and your auditor decides whether your evidence is sufficient. This file is a mapping starting point, not a substitute for the conversation with your auditor.

## Quick reference: control to gate

| TSC | Control | Gates that produce evidence |
|---|---|---|
| **CC1.5** | Holds individuals accountable | `ai-human-signoff` |
| **CC2.1** | Internal communications of objectives, responsibilities | `build-decision-recorded`, `change-reviewed`, `ai-human-signoff` |
| **CC3.1** | Specifies suitable objectives | `build-decision-recorded` |
| **CC3.2** | Identifies and analyzes risks | `risk-review-attached`, `ai-eval-cleared` (best-fit) |
| **CC3.4** | Identifies and analyzes significant changes | `risk-review-attached` |
| **CC4.1** | Evaluates internal control performance | `post-launch-feedback` |
| **CC5.3** | Deploys controls through policies | `policy-passed` |
| **CC6.1** | Logical access controls | `deploy-authorized` |
| **CC7.1** | Detection and monitoring of vulnerabilities | `tests-passed`, `policy-passed`, `deploy-logged`, `ai-adversarial-test` (best-fit), `ai-drift-monitor` (best-fit) |
| **CC7.2** | Monitoring for anomalies | `deploy-logged`, `ai-drift-monitor` (best-fit) |
| **CC7.3** | Response to incidents | `ai-drift-monitor` (best-fit) |
| **CC8.1** | Authorizes, designs, develops, configures, documents, tests, approves, implements changes | `build-decision-recorded`, `change-reviewed`, `tests-passed`, `policy-passed`, `deploy-authorized`, `ai-eval-cleared` (best-fit), `ai-adversarial-test` (best-fit) |
| **CC9.1** | Identifies, selects, develops risk mitigation | `risk-review-attached`, `post-launch-feedback` |

## How an auditor uses this

For each control above, the auditor asks "show me the evidence." The catalog's gates are designed so the evidence is the work product, not a separate document. The auditor's typical asks:

- **CC8.1 (change management):** show every change in a sampling window with its review record, test record, policy record, and signed deploy record. The catalog's five SDLC gates plus the AI-DLC eval gate produce all of these as a byproduct of the pipeline.
- **CC3.2 (risk identification):** show the risk reviews attached to material changes. The `risk-review-attached` gate produces this.
- **CC7.1 (detection):** show the policy and vulnerability scans for system components in scope. `policy-passed` and `tests-passed` produce this; `ai-adversarial-test` and `ai-drift-monitor` extend it to AI behavior.
- **CC1.5 (accountability):** show the named sign-offs on material releases. `ai-human-signoff` produces this for AI releases; for non-AI releases, the `deploy-authorized` gate often plays this role.

## What this catalog does NOT cover

SOC 2 reaches well beyond the SDLC. The catalog does not produce evidence for:

- **CC1.1–CC1.4:** organizational integrity, ethics, board oversight
- **CC2.2, CC2.3:** external communications
- **CC5.1–CC5.2:** general control selection at the organizational level
- **CC6.2–CC6.8:** broader logical access (user lifecycle, privileged access, MFA, encryption in transit/at rest, physical access)
- **CC7.4, CC7.5:** broader incident response and business continuity
- **CC8.1:** parts touching infrastructure-change management outside the SDLC (firewall changes, vendor-managed changes)
- **CC9.2:** vendor risk management
- **Availability, Confidentiality, Processing Integrity, Privacy:** additional criteria beyond Security, when in scope

You need separate evidence sources for those. The catalog covers the SDLC-shaped controls and is honest about its boundary.

## Notes for AI-DLC mappings

The four AI-DLC gates are mapped to SOC 2 best-fit controls. The fit is approximate because SOC 2 was written before generative AI and assumes deterministic test outcomes. See `docs/ai-dlc-extension.md` for the limits of these mappings and the emerging frameworks (ISO/IEC 42001, NIST AI RMF) where the fit is cleaner.

## References

- [AICPA Trust Services Criteria 2017](https://www.aicpa-cima.com/resources/download/2017-trust-services-criteria-with-revised-points-of-focus-2022)
- [TSC 2017 with revised points of focus (2022)](https://www.aicpa-cima.com/resources/download/2017-trust-services-criteria-with-revised-points-of-focus-2022)
