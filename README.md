# sdlc-control-gates

A take-and-modify catalog of SDLC control gates, the evidence each gate emits, and how that evidence maps to common compliance frameworks (SOC 2, ISO 27001, PCI DSS 4.0, HIPAA).

This is the working artifact behind the post [Standardize the Gates, Not the Steps](https://mattgoodrich.com/posts/standardize-the-gates-not-the-steps/). The premise: an auditable software process and a true software process are usually different documents because companies write down their steps when they should be writing down their gates. Gates are control points where evidence gets collected. Steps are how teams get between gates. Standardize the gates. Leave the steps alone.

![The Sixteen Gates Across Three Lifecycles: Three PDLC Gates (Build Decision Recorded, Risk Review Attached, Post-Launch Feedback), Nine SDLC Gates (Change Reviewed, Tests Passed, Policy Passed, Deploy Authorized, Deploy Logged, Author Training Current, Source Access Restricted, Test Data Clean, Dependency Provenance), and Four AI-DLC Gates (AI Eval Cleared, AI Adversarial Test, AI Human Sign-Off, AI Drift Monitor) Drawn as an Extension of the SDLC When AI Is in Scope](diagram-gates-overview.png)

## What's in here

- **[`catalog/SUMMARY.md`](catalog/SUMMARY.md)** — a single mega-table tying every gate to its evidence shape, framework controls in all four frameworks, and example file. Start here if you want to scan and decide.
- **`catalog/gates.yaml`** — the gates themselves, with the evidence each one emits, the tooling that typically produces that evidence, and the failure mode if the gate is missing. Sixteen gates: three PDLC, nine SDLC, four AI-DLC.
- **`catalog/mappings.yaml`** — each gate mapped to specific controls in SOC 2, ISO 27001, PCI DSS 4.0, and HIPAA, with notes on how the mapping works.
- **`frameworks/`** — one markdown per framework showing the controls referenced and what evidence satisfies each, written so an auditor and an engineer can both use it.
- **`examples/`** — working code: a Conftest policy that gates a Kubernetes manifest, a GitHub Actions workflow that emits the evidence record, a PR template that captures the review-gate evidence, and a minimal OSCAL component definition.
- **`docs/`** — guides for forking this for your org, adding a framework, and where AI-DLC gates currently fit (and don't fit) in the named frameworks.

## How to use this

1. Read `catalog/gates.yaml` and decide which gates apply to you. Most orgs cut at least two and add at least one. That's the point.
2. Read the framework markdown that matches your audit obligation. Each one shows you which gates produce evidence the auditor wants.
3. Take the examples directory as a starting point. The Conftest policy and GitHub Actions workflow are real working code; rename and adapt.
4. If you run a framework not in here (FedRAMP, DORA, NIS2, CMMC, NIST CSF, ISO 42001), see `docs/adding-a-framework.md` and open a pull request.

## What this is not

- **Not a substitute for an auditor.** The mappings are a starting point. Your auditor decides what evidence satisfies which control in your context.
- **Not a complete control library.** SOC 2, ISO 27001, PCI DSS, and HIPAA each have controls this catalog doesn't touch (physical access, vendor management, business continuity, incident response process, key management, privacy regulatory). This catalog covers the controls that the SDLC produces evidence for.
- **Not an opinion on which framework you should pursue.** The catalog works for whichever you're already on the hook for.

For the full statement of what's in scope, what's out, and the principle behind the boundary, see [`docs/scope.md`](docs/scope.md).

## AI-DLC

Four gates here are AI-specific: evaluation-against-threshold, adversarial/guardrail testing, named-human sign-off, and drift monitoring with rollback. None of SOC 2, ISO 27001, PCI DSS 4.0, or HIPAA names these directly. The mappings best-fit them to the closest existing control and flag the fit as approximate. As [ISO/IEC 42001](https://www.iso.org/standard/81230.html) (AI management systems) and the [NIST AI Risk Management Framework](https://www.nist.gov/itl/ai-risk-management-framework) gain audit traction, those will be added as their own framework files. See `docs/ai-dlc-extension.md`.

## License

[CC0 1.0 Universal](LICENSE). This is public domain. Use it, fork it, sell it, no attribution required. The point is for orgs to take this and run with it.

## Contributing

Pull requests welcome for:

- Additional frameworks (FedRAMP, NIST 800-53, NIST CSF 2.0, ISO 42001, DORA, NIS2, CMMC, HITRUST)
- More example gate implementations (Argo CD, Tekton, GitLab CI, Buildkite, Jenkins)
- OSCAL component definitions
- Corrections to existing mappings, with the auditor reasoning

Issues welcome for:

- Mappings you think are wrong (cite the control and your reasoning)
- Frameworks where the AI-DLC gates have a clearer fit than the catalog says
- Gates the catalog is missing
