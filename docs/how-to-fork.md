# How to fork this for your organization

The point of this repo is that you take it, drop what doesn't apply, and add what does. Here is the path of least friction.

## 1. Fork or copy

```bash
gh repo fork mgoodric/sdlc-control-gates --clone --remote
# or just download a tarball — the license (CC0) lets you do whatever
```

This is public domain. You do not need to keep the README, the LICENSE, the attribution, or anything else.

## 2. Cut the gates you do not have

Open `catalog/gates.yaml` and delete every gate you cannot currently produce evidence for. Be honest. A gate you "could" produce evidence for is not a gate. The auditor will sample, and "we usually do" is the same as "we sometimes do not."

Typical first-pass cuts:

- **No AI in production?** Delete the four `ai-*` gates.
- **No production yet (early-stage startup)?** Delete `deploy-authorized` and `deploy-logged` until you have production.
- **Small team, no separate PDLC artifact?** Delete `build-decision-recorded` and `post-launch-feedback` if your changes are all engineering-internal and you do not have product management.

The remaining gates are your contract. If the contract is small, that is fine. The argument is not "more gates is better" — it is that every gate you claim is real.

## 3. Add the gates you have that this catalog does not

Common additions:

- **Architecture-review gate** for changes that cross service boundaries
- **DPIA gate** for changes that introduce or expand processing of personal data
- **License-compliance gate** for OSS license enforcement
- **DB-migration-approval gate** when migrations are higher-risk than code changes
- **Feature-flag-cleanup gate** if you have a flag-debt policy
- **Vendor-onboarding gate** if vendor risk lives in your SDLC

Add them with the same shape: `id`, `name`, `lifecycle`, `description`, `evidence`, `tooling`, `fail_mode`.

## 4. Adjust the mappings

Open `catalog/mappings.yaml` and:

- **Remove framework rows you do not pursue.** If you do not handle card data, delete the PCI block on every gate.
- **Add framework rows for the controls your auditor cares about.** If they have requested specific control IDs not listed here, add them.
- **Edit the `note:` text** to match what your auditor accepts. The note text is the auditor-readable explanation of how the evidence satisfies the control.

If your auditor requests a framework not in this repo, see `adding-a-framework.md` and consider opening a pull request upstream.

## 5. Wire the example pipeline

The `examples/` directory has working starters:

- `examples/github-actions/emit-evidence.yml` — drop into `.github/workflows/`, adapt the placeholders
- `examples/conftest/policy.rego` — drop into a `policies/` directory in your repo
- `examples/pr-templates/pull_request_template.md` — drop into `.github/`
- `examples/oscal/component-definition.json` — adapt the UUIDs and component descriptions

Run them. The point is the evidence flows automatically; if it does not, the gate is theater.

## 6. Tell your auditor

When you have something running, send your auditor:

- The forked repo URL
- A walkthrough showing the evidence for a recent change (the GitHub Actions run, the PR with template completed, the signed deploy log entry)
- The frameworks/<your-framework>.md showing which of their controls you produce evidence for

Their feedback shapes the next iteration. Their wording about what "satisfies" a control is what you want in the `note:` field.

## 7. Keep it honest

The most common failure mode is letting a gate become a checkbox. Two practices keep gates real:

- **Quarterly review.** Sample your own evidence. If a gate never fails, either your inputs are perfect (unlikely) or the gate is not enforcing anything (likely). Inspect.
- **Add new gates from incidents.** When something goes wrong, ask whether a gate would have caught it. If yes and you do not have it, add it. If no, do not add one — the gate set is for repeated, evidenced control points, not one-off responses.

## What success looks like

When the auditor's annual visit becomes a query you run instead of a quarter you spend preparing for, the catalog is doing its job.
