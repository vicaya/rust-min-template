#!/usr/bin/env sh
# Replace this template's placeholder repo name ("skys3") and license owner
# ("skys3 contributors") with values for a newly generated project.
#
# Shared by:
#   - .github/workflows/template-init.yml (repos created via GitHub's
#     "Use this template" button)
#   - copier.yml (local generation via `copier copy`)
#
# Usage: customize-template.sh <repo-name> <owner> [dir]
set -eu

repo_name=${1:?"usage: customize-template.sh <repo-name> <owner> [dir]"}
owner=${2:?"usage: customize-template.sh <repo-name> <owner> [dir]"}
dir=${3:-.}

cd "$dir"

# Idempotent: only run while the pristine placeholder is still present, so
# re-running this script (or the workflow that calls it) is always a no-op
# once customization has happened, regardless of what the new name is.
if ! grep -qx 'name = "skys3"' Cargo.toml 2>/dev/null; then
  echo "Template already customized; nothing to do."
  exit 0
fi

# Cargo package names must be non-empty, contain only ASCII letters, digits,
# '-' or '_', and must start with a letter or underscore.
package_name=$(printf '%s' "$repo_name" | sed -E 's/[^A-Za-z0-9_-]+/-/g')
case "$package_name" in
  [0-9]* | -*) package_name="crate-${package_name}" ;;
esac

sed -i.bak \
  -e "s/^name = \"skys3\"\$/name = \"${package_name}\"/" \
  -e "s/description = \"Rust bootstrap for the skys3 repository.\"/description = \"Rust bootstrap for the ${repo_name} repository.\"/" \
  -e "s#repository = \"https://github.com/skys3/skys3\"#repository = \"https://github.com/${owner}/${repo_name}\"#" \
  Cargo.toml

sed -i.bak \
  -e "s/^# skys3\$/# ${repo_name}/" \
  -e "s/the \`skys3\` repository/the \`${repo_name}\` repository/" \
  README.md

sed -i.bak \
  "s/assert_eq!(env!(\"CARGO_PKG_NAME\"), \"skys3\");/assert_eq!(env!(\"CARGO_PKG_NAME\"), \"${package_name}\");/" \
  src/lib.rs

sed -i.bak "s/Copyright 2026 skys3 contributors/Copyright 2026 ${owner} contributors/" LICENSE

rm -f Cargo.toml.bak README.md.bak src/lib.rs.bak LICENSE.bak
