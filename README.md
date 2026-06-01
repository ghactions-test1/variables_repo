# variables_repo

Examples for learning how values move through GitHub Actions workflows.

## Workflows

- `.github/workflows/blank.yml` demonstrates repository, organization, environment, workflow, job, and step scoped variables.
- `.github/workflows/passing_values.yml` demonstrates passing values between steps, passing job outputs between jobs, and passing files between jobs with artifacts.
- `.github/workflows/matrix.yml` demonstrates a manually dispatched workflow that combines user inputs with a Node.js version and operating system matrix.

## Matrix workflow

The `dispatch_matrix` workflow can be run manually from the GitHub Actions tab. It asks for a log level and target environment, then runs every combination of:

- Node.js `20`, `22`, and `24`
- `ubuntu-latest` and `windows-latest`
