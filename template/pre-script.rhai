// cargo-generate only provides `project-name` (kebab-case) and `crate_name`
// (snake_case). Expose the project name as `project_name` as well.
variable::set("project_name", variable::get("project-name"));
