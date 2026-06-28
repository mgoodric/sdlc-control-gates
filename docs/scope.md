# What this catalog is and is not

The catalog has one job: produce evidence at the gates where software releases meet controls. That's the boundary. This file names the principle behind the boundary and the categories that fall outside it, so readers do not mistake the catalog for more than it claims to be.

## The principle

A control belongs in the catalog if and only if it is **gate-shaped**:

> Gate-shaped means the control emits evidence at a discrete control point in the release flow, as a byproduct of the work itself.

Three tests:

1. **Discrete.** The control fires at a moment — a PR merging, a CI run completing, an artifact being signed — not continuously across the lifetime of a system.
2. **In the release flow.** The control sits on the path between someone wanting to ship something and the thing actually shipping. A control that does not interact with that path is not gate-shaped.
3. **Byproduct.** The evidence comes from the work, not from someone remembering to write a document afterward. If a quarterly screenshot satisfies the control, it is not gate-shaped.

Plenty of controls fail one or more of those tests. They are not lesser controls; they are different controls. The catalog is honest about what shape it serves.

## What is out of scope, and why

| Category | Examples | Why it is out | Where it belongs |
|---|---|---|---|
| **Operations & infrastructure** | Backup verification, encryption at rest, network segmentation, KMS / HSM operation, anti-malware, vulnerability scanning of running systems | Steady-state, not release-gated. The evidence is continuous monitoring, not a per-release artifact. | Platform runbook, infrastructure-as-code repo, observability stack |
| **Incident response & resilience** | IR runbooks, tabletop exercises, BCP / DR procedures, RPO / RTO targets, breach notification workflows | Triggered by events, not produced by releases. Activated when something fails, not when something ships. | IR playbook, BCP / DR documentation, on-call rotation tooling |
| **People process** | Training program design, role definitions, segregation-of-duties policy, security awareness campaigns | The *training record* is gate-shaped (`author-training-current`). The *program* that produces and maintains the training is policy and HR work. | HR / People Ops, security policy library |
| **Physical security** | Data center controls, device disposal, badge access, visitor logs | Not produced by software work. The release flow has no interaction with the loading dock. | Facilities and IT operations |
| **Privacy regulatory** | GDPR / CCPA data-subject rights, consent records, retention schedules, deletion workflows, DPIA-on-demand | Specific to data-subject interactions and steady-state data handling, not release events. A change that touches privacy uses `risk-review-attached`; the program does not. | Privacy program, data governance, separate DPIA tooling |
| **Vendor & supply-chain governance** | BAAs, MSAs, fourth-party due diligence, vendor offboarding, SaaS app discovery | Procurement-shaped, not release-shaped. `dependency-provenance` is the catalog's slice of supply chain — what your code links against. The rest is a different process. | Vendor management / procurement |
| **Cryptography key management** | Key rotation procedure, HSM ceremony evidence, cryptoperiods | Operations, not release. The release uses keys at `deploy-authorized`; it does not manage them. | KMS runbook, cryptographic policy |
| **AI governance beyond gates** | Model cards, dataset cards, fairness audits, training-data licensing, model registry | Documents and standing artifacts, not release-time gates. The gates produce the eval, adversarial, sign-off, and drift evidence; the broader governance is a separate program. | Sibling AI-governance artifact, model registry tooling |
| **Framework-specific non-SDLC** | PCI Reqs 1–5 (network, encryption, anti-malware, account configuration), HIPAA physical safeguards, ISO 27001 physical theme, SOC 2 availability / confidentiality / privacy criteria | The catalog's premise is SDLC-shaped. These criteria need their own programs and evidence sources. | Your broader compliance program |

## Non-goals

Stated plainly so no one mistakes the catalog for what it is not:

- **Not a complete ISMS.** ISO 27001 certification requires a documented management system this catalog is one tool inside, not a substitute for.
- **Not a SOC 2 readiness package.** SOC 2 audits sample evidence across criteria this catalog only partially covers.
- **Not a PCI compliance kit.** PCI DSS 4.0 has twelve requirements; this catalog produces evidence for parts of four of them.
- **Not a HIPAA compliance kit.** The Security Rule has administrative, physical, and technical safeguards; this catalog touches parts of administrative and technical.
- **Not a substitute for an auditor.** Mappings are starting points. Your auditor decides what evidence satisfies which control in your context.
- **Not a checklist that produces compliance.** Adopting every gate is necessary for these frameworks, not sufficient.

## How to read the boundary

If a framework names a control the catalog does not cover, the framework MD lists it under "What this catalog does NOT cover." That section is deliberate — the missing items are not omissions, they are honest scope statements.

If your auditor asks for evidence the catalog does not produce, the answer is not "the catalog is incomplete." The answer is "that evidence lives in our [ISMS / IR playbook / privacy program / vendor process / etc.]." The catalog is one input to a broader program. It is honest about being one input.

## When to extend the catalog

If a control trips all three tests above (discrete, in the release flow, byproduct) and is not in the catalog, open a pull request. That is how `author-training-current`, `source-access-restricted`, `test-data-clean`, and `dependency-provenance` got added — each one tripped the tests, and each was missing.

If a control fails one or more tests, the right move is to add it to your sibling artifacts, not to bend the catalog around it.
