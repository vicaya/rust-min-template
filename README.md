# rust-min-template

[![CI](https://github.com/vicaya/rust-min-template/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/vicaya/rust-min-template/actions/workflows/ci.yml?query=branch%3Amain)
[![Tests](https://github.com/vicaya/rust-min-template/raw/badges/main/tests.svg)](https://github.com/vicaya/rust-min-template/actions/workflows/ci.yml?query=branch%3Amain)
[![Coverage](https://github.com/vicaya/rust-min-template/raw/badges/main/coverage.svg)](https://github.com/vicaya/rust-min-template/actions/workflows/ci.yml?query=branch%3Amain)

A minimal Rust crate template for [cargo-generate].

## Usage

```bash
cargo install cargo-generate
cargo generate vicaya/rust-min-template --name my-crate
```

This creates `my-crate/` with every `{{project_name}}` placeholder replaced by
`my-crate`. cargo-generate also asks for the GitHub owner used in the README
badges; pass `--define github_owner=<owner>` to skip the prompt.

GitHub's "Use this template" button copies the files without filling in the
placeholders, so use `cargo generate` instead.

## What you get

- `Cargo.toml` for a library crate (edition 2024, `rust-version = "1.98.1"`,
  no dependencies).
- `src/lib.rs` with `#![forbid(unsafe_code)]`, the README as crate docs, and a
  smoke test.
- GitHub Actions CI: `rustfmt`, `clippy -D warnings`, tests, doctests,
  `rustdoc -D warnings`, a line coverage gate, and a `cargo check` on the
  declared minimum Rust version.
- A `cargo coverage` alias in `.cargo/config.toml` that runs
  [cargo-llvm-cov] and fails below 85% line coverage (change
  `--fail-under-lines` to move the threshold). CI runs the same alias.
- CI, tests, and coverage badges in the README. On pushes to `main`, CI
  renders the test count and line coverage as SVG badges
  (`scripts/ci/badge.sh`) on a `badges` branch, which the README embeds
  through `github.com/<owner>/<repo>/raw/...`. They need no external service
  and render in private repositories too; the publishing job checks that
  GitHub serves them from the rendered README.
- `AGENTS.md` with the pull request branch naming convention for coding
  agents: `<agent-name>/<name-describing-the-task>`, e.g. `claude/...`.
- Dependabot for GitHub Actions and Cargo.
- `FSL-1.1-ALv2` license, copyright Sky Computing LLC. The copyright year is
  set to the year you generate the project.

## Placeholders

| Placeholder        | Value                                     |
| ------------------ | ----------------------------------------- |
| `{{project_name}}` | The `--name` passed to `cargo generate`   |
| `{{github_owner}}` | GitHub user or org, default `vicaya`      |

The README badges assume the repository is
`github.com/{{github_owner}}/{{project_name}}`.

cargo-generate's built-in `{{project-name}}` and `{{crate_name}}` also work.
`template/pre-script.rhai` sets `project_name`.

## Layout

```text
AGENTS.md                # conventions for coding agents in this repository
cargo-generate.toml      # points cargo-generate at template/
.github/workflows/ci.yml # tests this template (not copied into projects)
template/                # the files that make up a generated project
```

The template is kept in `template/` so this repository's own CI can generate a
project and run the full check suite against it on every push. The tests and
coverage badges above are the generated project's, published with the
template's own `template/scripts/ci/publish-badges.sh`.

## Developing the template

```bash
cargo generate --path . --name smoke-test --destination /tmp --vcs none --silent
cd /tmp/smoke-test && cargo clippy --all-targets -- -D warnings && cargo coverage
```

Files under `template/.github/` and `template/scripts/` are copied verbatim,
so GitHub Actions `${{ ... }}` expressions are not treated as Liquid
placeholders there, and this repository's CI runs the badge scripts straight
from `template/scripts/ci/`. Anywhere else in `template/`, write a literal `{{`
as `{{ "{{" }}`.

## License

Copyright 2026 Sky Computing LLC. Licensed under `FSL-1.1-ALv2`; see
`LICENSE`.

[cargo-generate]: https://github.com/cargo-generate/cargo-generate
[cargo-llvm-cov]: https://github.com/taiki-e/cargo-llvm-cov
