# {{project_name}}

[![CI](https://github.com/{{github_owner}}/{{project_name}}/actions/workflows/ci.yml/badge.svg)](https://github.com/{{github_owner}}/{{project_name}}/actions/workflows/ci.yml)
[![Coverage](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/{{github_owner}}/{{project_name}}/badges/coverage.json)](https://github.com/{{github_owner}}/{{project_name}}/actions/workflows/ci.yml)

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

On pushes to `main`, CI writes the line coverage to `coverage.json` on the
`badges` branch, which the coverage badge above reads. The badge only works
for public repositories.

## License

Copyright Sky Computing LLC. Licensed under the Functional Source License,
Version 1.1, Apache License 2.0 Future License (`FSL-1.1-ALv2`). See `LICENSE`
for the full text.
