#!/usr/bin/env sh
# Render this template's tracked `*.jinja` files (the same ones Copier
# renders for `copier copy`) into their plain counterparts, filling in the
# destination repo's name and license owner. Used when a repo is generated
# via GitHub's "Use this template" button, since GitHub only copies files
# and never runs Copier/Jinja itself.
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
# '-' or '_', and must start with a letter or underscore. Copier's own
# `project_name` question enforces this same rule via a validator, but a
# destination repo created via GitHub's "Use this template" button may
# already have an invalid name that we can't ask anyone to fix, so sanitize
# it instead of rejecting it.
project_name=$(printf '%s' "$repo_name" | sed -E 's/[^A-Za-z0-9_-]+/-/g')
case "$project_name" in
  [0-9]* | -*) project_name="crate-${project_name}" ;;
esac

render() {
  sed \
    -e "s/{{ project_name }}/${project_name}/g" \
    -e "s/{{ repo_name }}/${repo_name}/g" \
    -e "s/{{ license_owner }}/${owner}/g" \
    "$1" > "$2"
}

render Cargo.toml.jinja Cargo.toml
render README.md.jinja README.md
render src/lib.rs.jinja src/lib.rs
render LICENSE.jinja LICENSE
