# HIPAA Security Rule (45 CFR Part 164)

This file shows which HIPAA Security Rule sections the gate catalog produces evidence for, and how the evidence satisfies the implementation specification.

HIPAA's Security Rule (subpart C of Part 164) governs the protection of electronic protected health information (ePHI). It is structured as Administrative Safeguards (§164.308), Physical Safeguards (§164.310), Technical Safeguards (§164.312), Organizational Requirements (§164.314), and Policies/Procedures/Documentation (§164.316). The catalog produces evidence primarily for SDLC-shaped portions of the Administrative and Technical Safeguards.

HIPAA distinguishes "required" implementation specifications (must implement) from "addressable" ones (must implement or document why an equivalent measure is in place). The mappings below treat both shapes; the README of your fork should document which addressable specs your org chose to implement or replace.

## Quick reference: implementation spec to gate

| Section | Implementation Specification | Gates that produce evidence |
|---|---|---|
| **§164.308(a)(1)(ii)(A)** | Risk analysis (required) | `build-decision-recorded`, `risk-review-attached` |
| **§164.308(a)(1)(ii)(B)** | Risk management (required) | `risk-review-attached`, `change-reviewed` |
| **§164.308(a)(1)(ii)(D)** | Information system activity review (required) | `deploy-logged`, `post-launch-feedback`, `dependency-provenance`, `ai-drift-monitor` |
| **§164.308(a)(2)** | Assigned security responsibility (required) | `ai-human-signoff` |
| **§164.308(a)(3)** | Workforce security (required) | `deploy-authorized` |
| **§164.308(a)(4)** | Information access management (required) | `change-reviewed`, `source-access-restricted`, `test-data-clean` |
| **§164.308(a)(5)** | Security awareness and training (required) | `author-training-current` |
| **§164.308(a)(6)** | Security incident procedures (required) | `ai-drift-monitor` |
| **§164.308(a)(8)** | Evaluation (required) | `tests-passed`, `policy-passed`, `dependency-provenance`, `ai-eval-cleared`, `ai-adversarial-test` |
| **§164.312(a)(1)** | Access control (required) | `deploy-authorized`, `source-access-restricted` |
| **§164.312(b)** | Audit controls (required) | `deploy-logged` |
| **§164.312(c)(1)** | Integrity (required) | `policy-passed`, `test-data-clean` |

## How an auditor (OCR or external assessor) uses this

HIPAA enforcement comes through the Office for Civil Rights (OCR) when there is a breach or complaint; internal compliance audits and third-party assessors look at similar evidence proactively. The expectations:

- **§164.308(a)(1) (Security Management Process):** OCR wants to see that you have a process to identify, assess, and reduce risks to ePHI. The PDLC gates (`build-decision-recorded`, `risk-review-attached`) plus the SDLC change-management gates produce evidence that risk is considered for every change that touches ePHI systems.
- **§164.308(a)(8) (Evaluation):** periodic technical and non-technical evaluation. `tests-passed`, `policy-passed`, and (for AI systems) `ai-eval-cleared` and `ai-adversarial-test` are direct evidence.
- **§164.312(b) (Audit controls):** mechanisms that record and examine activity in systems containing ePHI. `deploy-logged` is direct evidence for deploy-side activity; user-side audit logs are a separate concern.
- **§164.312(c)(1) (Integrity):** ePHI must not be improperly altered or destroyed. `policy-passed` produces evidence that infrastructure changes were checked against integrity-related policies before deploy.

## What this catalog does NOT cover

The Security Rule reaches well beyond the SDLC. The catalog does not produce evidence for:

- **§164.308(a)(5):** security awareness and training
- **§164.308(a)(7):** contingency plan (backups, disaster recovery)
- **§164.310:** all physical safeguards
- **§164.312(a)(2):** unique user identification, emergency access, automatic logoff, encryption / decryption of ePHI
- **§164.312(c)(2):** mechanism to authenticate ePHI
- **§164.312(d):** person or entity authentication
- **§164.312(e):** transmission security
- **§164.314:** organizational requirements (BAAs, group health plan provisions)
- **§164.316:** policies and procedures, documentation retention (six-year requirement)

You need a broader HIPAA compliance program for those. The catalog covers the SDLC-shaped portion of the Administrative and Technical Safeguards.

## Notes for AI-DLC mappings

HIPAA was written in 2003 and predates generative AI. The AI-DLC gates map to §164.308(a)(8) Evaluation as best-fit, and to §164.308(a)(2) Assigned security responsibility for the human sign-off. If your AI system processes ePHI, the agent itself is in-scope for HIPAA and the AI-DLC gates produce additive evidence.

The Department of Health and Human Services has begun publishing guidance on AI in healthcare; as that guidance crystallizes, mappings will be added. See `docs/ai-dlc-extension.md`.

## References

- [45 CFR Part 164 (eCFR)](https://www.ecfr.gov/current/title-45/subtitle-A/subchapter-C/part-164)
- [HHS HIPAA Security Rule summary](https://www.hhs.gov/hipaa/for-professionals/security/laws-regulations/index.html)
- [NIST SP 800-66 Rev. 2 (HIPAA implementation guide)](https://csrc.nist.gov/pubs/sp/800/66/r2/final)
