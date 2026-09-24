# rust-min-template

A minimal Rust crate template for [cargo-generate].

## Usage

```bash
cargo install cargo-generate
cargo generate vicaya/rust-min-template --name my-crate
```

This creates `my-crate/` with every `{{project_name}}` placeholder replaced by
`my-crate`.

GitHub's "Use this template" button copies the files without filling in the
placeholders, so use `cargo generate` instead.

## What you get

- `Cargo.toml` for a library crate (edition 2024, `rust-version = "1.85"`,
  no dependencies).
- `src/lib.rs` with `#![forbid(unsafe_code)]`, the README as crate docs, and a
  smoke test.
- GitHub Actions CI: `rustfmt`, `clippy -D warnings`, tests, doctests,
  `rustdoc -D warnings`, and a `cargo check` on the declared minimum Rust
  version.
- Dependabot for GitHub Actions and Cargo.
- `FSL-1.1-ALv2` license, copyright Sky Computing LLC. The copyright year is
  set to the year you generate the project.

## Placeholders

| Placeholder        | Value                                   |
| ------------------ | --------------------------------------- |
| `{{project_name}}` | The `--name` passed to `cargo generate` |

cargo-generate's built-in `{{project-name}}` and `{{crate_name}}` also work.
`template/pre-script.rhai` sets `project_name`.

## Layout

```text
cargo-generate.toml      # points cargo-generate at template/
.github/workflows/ci.yml # tests this template (not copied into projects)
template/                # the files that make up a generated project
```

The template is kept in `template/` so this repository's own CI can generate a
project and run the full check suite against it on every push.

## Developing the template

```bash
cargo generate --path . --name smoke-test --destination /tmp --vcs none --silent
cd /tmp/smoke-test && cargo clippy --all-targets -- -D warnings && cargo test
```

Files under `template/.github/` are copied verbatim, so GitHub Actions
`${{ ... }}` expressions are not treated as Liquid placeholders there. Anywhere
else in `template/`, write a literal `{{` as `{{ "{{" }}`.

## License

Copyright 2026 Sky Computing LLC. Licensed under `FSL-1.1-ALv2`; see
`LICENSE`.

[cargo-generate]: https://github.com/cargo-generate/cargo-generate
