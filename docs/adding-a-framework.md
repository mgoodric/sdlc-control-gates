# Adding a framework

The catalog is set up to absorb additional frameworks without touching the gates. Each framework lives as one file in `frameworks/` and one block per gate in `catalog/mappings.yaml`.

## Frameworks that should probably go next

In rough order of community demand:

1. **NIST 800-53** (FedRAMP and federal contractors)
2. **NIST CSF 2.0** (US infrastructure, rising private-sector adoption)
3. **ISO/IEC 42001:2023** (AI management systems — directly addresses AI-DLC gates)
4. **NIST AI RMF** (AI risk, US federal influence)
5. **DORA** (EU financial services, in force)
6. **NIS2** (EU general, in force)
7. **CMMC 2.0** (US defense industrial base)
8. **HITRUST CSF** (healthcare, prescriptive)
9. **CIS Controls v8** (general defensive baseline)
10. **SOX (ITGC)** (US-listed companies — change management, access)

If you do the work, please open a PR.

## The shape

For framework `XYZ`, you write two things:

### One file at `frameworks/XYZ.md`

Follow the template established by the existing files:

- Brief intro: what the framework is, what version, what date
- Quick-reference table: control → list of gates that produce evidence
- "How an auditor uses this" walkthrough (one paragraph per major control area)
- "What this catalog does NOT cover" — the controls in the framework that the SDLC does not produce evidence for. Be honest. Half the value of this artifact is its honest scope.
- Notes for AI-DLC mappings (if the framework predates generative AI)
- References (canonical source + version)

### One block per gate in `catalog/mappings.yaml`

For each of the 12 gates, add a key under that gate's mapping with the framework's controls:

```yaml
mappings:
  change-reviewed:
    # ... existing soc2, iso27001, pci-dss-4, hipaa blocks ...
    xyz:
      - id: <CONTROL-ID>
        note: |
          One-paragraph explanation of how the evidence from this gate
          satisfies this control. Written so an auditor and an engineer
          can both read it.
```

If a gate has no fit in the framework, omit the framework block for that gate (do not include an empty list — the absence is the answer).

## Quality bar for mappings

Each mapping needs three things to land:

1. **A real control ID.** Cite the framework's own ID. No invented or paraphrased identifiers.
2. **A reasoning sentence in `note:`.** Explain why the gate's evidence satisfies this control. If you cannot write the sentence, the mapping is probably wrong.
3. **A `BEST-FIT` flag on approximate matches.** When the control was not designed for what the gate does (most AI-DLC mappings, anything where the framework predates the technology), put `BEST-FIT.` at the start of the `note:`. This is honesty, not weakness.

Bad mapping (rejected):

```yaml
xyz:
  - id: AC-1
    note: Access control.
```

Good mapping (accepted):

```yaml
xyz:
  - id: AC-1
    note: |
      Access Control Policy and Procedures. The deploy-authorized gate
      enforces the procedure side: every production change requires
      a signed authorization from an identity with deploy permissions.
      The policy side (the document) is referenced separately in
      your ISMS / security policy.
```

## Things to avoid

- **Do not invent gates to fit a framework.** The catalog starts from gates and maps to controls, not the other way. If a framework names a control with no gate-shaped evidence, list it under "What this catalog does NOT cover" and stop.
- **Do not pad the mappings.** Three carefully-chosen controls per gate beat eight near-misses.
- **Do not skip the "what's NOT covered" section.** Auditors trust artifacts that name their boundaries.

## Sanity-check before opening the PR

- The framework MD compiles cleanly when read as a doc (links work, control IDs are consistent between MD and YAML).
- Every gate has zero or one block for your framework in `mappings.yaml` — never two.
- The README's framework list at the top includes the new one.
