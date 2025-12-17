## Danger

[Danger](http://danger.systems) runs during Grape projects' CI process, and gives you a chance to automate common code review chores.

[![Build Status](https://travis-ci.org/ruby-grape/danger.svg?branch=master)](https://travis-ci.org/ruby-grape/danger)

# Table of Contents

- [Setup](#setup)
  - [Add Danger](#add-danger)
  - [Add Dangerfile](#add-dangerfile)
  - [Add GitHub Actions Workflows](#add-github-actions-workflows)
  - [Commit via a Pull Request](#commit-via-a-pull-request)
- [Reusable Workflows](#reusable-workflows)
  - [Architecture](#architecture)
  - [Benefits of Reusable Workflows](#benefits-of-reusable-workflows)
  - [How It Works](#how-it-works)
  - [Examples](#examples)
- [License](#license)

## Setup

Enable Danger for a project within the [ruby-grape organization](https://github.com/ruby-grape).

### Add Danger

Add `ruby-grape-danger` to `Gemfile`.

```ruby
gem 'ruby-grape-danger', require: false
```

### Add Dangerfile

Create a `Dangerfile` in your project's root that imports `ruby-grape-danger` and adds your project-specific checks:

```ruby
danger.import_dangerfile(gem: 'ruby-grape-danger')

# Your project-specific danger checks
changelog.check!
toc.check!
```

The `ruby-grape-danger` Dangerfile automatically handles:
- Setting up the reporting infrastructure
- Exporting the danger report via `at_exit` hook when the Dangerfile finishes
- Consistent output format for the workflow

### Add GitHub Actions Workflows

Create `.github/workflows/danger.yml`:

```yaml
name: Danger
on:
  pull_request:
    types: [ opened, reopened, edited, synchronize ]
  workflow_call:

jobs:
  danger:
    uses: ruby-grape/danger/.github/workflows/danger-run.yml@main
```

Create `.github/workflows/danger-comment.yml`:

```yaml
name: Danger Comment
on:
  workflow_run:
    workflows: [Danger]
    types: [completed]
  workflow_call:

jobs:
  comment:
    uses: ruby-grape/danger/.github/workflows/danger-comment.yml@main
```

### Commit via a Pull Request

To test things out, make a dummy entry in `CHANGELOG.md` that doesn't match the standard format and make a pull request. Iterate until green.

## Reusable Workflows

This gem provides **reusable GitHub Actions workflows** that can be referenced by any Grape project to implement standardized Danger checks with consistent reporting.

### Architecture

The workflows are separated into two stages:

1. **danger-run.yml**: Executes Danger checks and generates a report
   - Runs `bundle exec danger dry_run` with your project's Dangerfile
   - Generates a JSON report of check results
   - Uploads the report as an artifact

2. **danger-comment.yml**: Posts/updates PR comments with results
   - Downloads the Danger report artifact
   - Formats and posts results as a PR comment
   - Updates existing comment on subsequent runs

### How It Works

When you reference the reusable workflows:

```yaml
uses: ruby-grape/danger/.github/workflows/danger-run.yml@main
```

GitHub Actions:
1. Checks out **your project's repository** (not ruby-grape-danger)
2. Installs dependencies from **your Gemfile**
3. Runs danger using **your Dangerfile**
   - Your Dangerfile imports `ruby-grape-danger`'s Dangerfile via `danger.import_dangerfile(gem: 'ruby-grape-danger')`
   - The imported Dangerfile registers an `at_exit` hook for automatic reporting
   - Runs your project-specific checks (added after the import)
   - When Dangerfile finishes, the `at_exit` hook automatically exports the report
4. The report is uploaded as an artifact for the commenting workflow

Each project maintains its own Dangerfile with project-specific checks, while the `ruby-grape-danger` gem provides shared infrastructure for consistent reporting and workflow execution.

### Examples

- [danger-changelog](https://github.com/ruby-grape/danger-changelog) - Validates CHANGELOG format
- [grape](https://github.com/ruby-grape/grape) - Multi-check danger implementation

## License

MIT License. See [LICENSE](LICENSE) for details.

