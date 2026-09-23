# skys3

A minimal Rust crate bootstrap for the `skys3` repository.

## Using this template

Click **Use this template** on GitHub to create a new repository from this
one. On the first push to the new repository, the "Customize template"
workflow automatically replaces the `skys3` placeholder with your
repository's name in `Cargo.toml`, `README.md`, and `src/lib.rs`, and
defaults the copyright owner in `LICENSE` to your repository's owner. Feel
free to edit any of these files afterwards if you need different values.

## Development

```bash
cargo fmt --check
cargo clippy --all-targets --all-features -- -D warnings
cargo test --all-targets
```

## CI

GitHub Actions runs the same formatting, lint, and test checks on every push
and pull request using Node-24-safe action versions to avoid Node 20
deprecation warnings.

## License

Licensed under the Functional Source License, Version 1.1, Apache License 2.0
Future License (`FSL-1.1-ALv2`). See `/LICENSE` for the full text.