# {{project_name}}

A minimal Rust crate.

## Development

```bash
cargo fmt --check
cargo clippy --all-targets --all-features -- -D warnings
cargo test --all-features
```

## CI

GitHub Actions runs the same formatting, lint, test, and doc checks on pushes
to `main` and on pull requests, plus a `cargo check` on the minimum supported
Rust version declared in `Cargo.toml`. Dependabot keeps actions and crates up
to date.

## License

Copyright Sky Computing LLC. Licensed under the Functional Source License,
Version 1.1, Apache License 2.0 Future License (`FSL-1.1-ALv2`). See `LICENSE`
for the full text.
