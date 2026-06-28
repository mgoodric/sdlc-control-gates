# AI-DLC extension: where the gates fit and where they don't

The four AI-DLC gates — `ai-eval-cleared`, `ai-adversarial-test`, `ai-human-signoff`, `ai-drift-monitor` — do not have direct equivalents in SOC 2, ISO 27001:2022, PCI DSS 4.0, or HIPAA. The mappings in `catalog/mappings.yaml` and the framework files use best-fit assignments to the closest existing control, flagged `BEST-FIT.` in the note.

This file explains the limits of those mappings and the emerging frameworks that fit cleanly.

## Why the existing frameworks do not fit

SOC 2, ISO 27001, PCI DSS, and HIPAA were written under the assumption that software produces deterministic outputs the auditor can compare to a specification. The four AI-DLC gates exist because that assumption does not hold for generative AI:

- **Eval against threshold.** SOC 2 CC8.1 expects tests to pass or fail. Evals are probabilistic: a release crosses a measured threshold on a held-out set, not a per-input correctness assertion. Mapping `ai-eval-cleared` to CC8.1 is a stretch.
- **Adversarial testing.** ISO 27001 A.8.29 covers security testing in development. Adversarial corpora exercise a category of risk (prompt injection, jailbreaks, abuse cases) that A.8.29 does not name. The mapping works because the shape is similar; the control was not written for it.
- **Named human sign-off.** SOC 2 CC1.5 (accountability) is close, but it is general — every control has accountability somewhere. Naming a human specifically for AI behavior is a stronger and narrower claim, because evals cannot score tone, helpfulness, or judgment.
- **Drift monitoring.** ISO 27001 A.8.16 (monitoring) is the right shape but does not address model drift specifically. PCI DSS 11.5 is closer in mechanism (detection of unexpected change) but card data is the wrong subject.

The mappings produce defensible audit evidence because the controls are shaped similarly; they are best-fit because the controls were not written with these gates in mind.

## Frameworks that fit cleanly

Two emerging frameworks directly address the AI-DLC gates and should get their own framework files when audit traction makes the work worth doing:

### ISO/IEC 42001:2023 — AI Management Systems

The first management-system standard for AI. It mirrors ISO 27001's structure (PDCA cycle, leadership, planning, support, operation, performance evaluation, improvement) but the controls in Annex A and Annex B are AI-specific.

Direct fits:

- **Annex A.6.2 (AI system impact assessment)** → `risk-review-attached` for AI work
- **Annex A.6.2.5 (data quality for AI)** → adjacent to `ai-eval-cleared` (eval set quality)
- **Annex A.6.2.6 (data for development)** → `ai-eval-cleared` (held-out set discipline)
- **Annex A.7.4 (verification and validation)** → `ai-eval-cleared`, `ai-adversarial-test`
- **Annex A.9.2 (allocation of responsibilities)** → `ai-human-signoff`
- **Annex A.10.3 (system documentation and information)** → `ai-drift-monitor` (release records)

Open a PR adding `frameworks/iso-42001.md` and the `iso-42001:` block to each AI-DLC gate's mapping when your org or an early adopter has done the work against an auditor.

### NIST AI Risk Management Framework (AI RMF)

NIST AI 100-1, with the Generative AI Profile (NIST AI 600-1). Not a certifiable standard, but US federal influence makes it likely to underwrite procurement and contract language.

Direct fits:

- **GOVERN-1** (policies, accountability) → `ai-human-signoff`
- **MAP-2** (categorization of AI risks) → `risk-review-attached` (for AI scope)
- **MEASURE-2** (analysis and assessment) → `ai-eval-cleared`, `ai-adversarial-test`
- **MANAGE-2** (risk treatment and tracking) → `ai-drift-monitor`

NIST AI RMF is a profile, not a certification, so the mappings are advisory rather than auditable. Useful for procurement language.

## What this catalog deliberately does not address

Three AI-adjacent concerns are out of scope for this catalog because they are not gate-shaped:

- **Model card and data card publication.** These are documents, not evidence-emitting gates. Reference the model card from the release record; do not turn the card itself into a gate.
- **Training-data provenance and licensing.** A separate problem (model supply chain) with its own emerging standards (Coalition for Content Provenance and Authenticity, Content Authenticity Initiative). Belongs in a sibling repo or a separate workstream.
- **Algorithmic fairness audits.** Important and framework-touching (NYC LL 144, EU AI Act, several US state laws), but the audit shape is "show the bias measurement and the mitigation," which the eval gate produces evidence for at the technical layer. The legal compliance layer is a separate concern.

If you bring AI to a regulated domain, plan for these explicitly. The catalog covers the SDLC-shaped portion.
