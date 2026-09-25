# {{project_name}}

[![CI](https://github.com/{{github_owner}}/{{project_name}}/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/{{github_owner}}/{{project_name}}/actions/workflows/ci.yml?query=branch%3Amain)
[![Tests](https://github.com/{{github_owner}}/{{project_name}}/raw/badges/main/tests.svg)](https://github.com/{{github_owner}}/{{project_name}}/actions/workflows/ci.yml?query=branch%3Amain)
[![Coverage](https://github.com/{{github_owner}}/{{project_name}}/raw/badges/main/coverage.svg)](https://github.com/{{github_owner}}/{{project_name}}/actions/workflows/ci.yml?query=branch%3Amain)

A minimal Rust crate.

## Development

```bash
cargo fmt --check
cargo clippy --all-targets --all-features -- -D warnings
cargo test --all-features
cargo coverage
```

`cargo coverage` is an alias (in `.cargo/config.toml`) for `cargo llvm-cov`
that fails if line coverage is below 85%. Change `--fail-under-lines` there to
move the threshold. It needs `cargo install cargo-llvm-cov` and
`rustup component add llvm-tools-preview`.

## CI

GitHub Actions runs the same formatting, lint, test, doc, and coverage checks
on pushes to `main` and on pull requests, plus a `cargo check` on the minimum
supported Rust version declared in `Cargo.toml`. Dependabot keeps actions and
crates up to date.

The tests and coverage badges above are generated on every push to `main`
and stored as SVG files on the `badges` branch
(`scripts/ci/publish-badges.sh`, rendered by `scripts/ci/badge.sh`), so they
need no external service and render in a private repository too. The job
that publishes them checks that GitHub serves them as images from the
rendered README (`scripts/ci/verify-badges-render.sh`).

## License

Copyright Sky Computing LLC. Licensed under the Functional Source License,
Version 1.1, Apache License 2.0 Future License (`FSL-1.1-ALv2`). See `LICENSE`
for the full text.
