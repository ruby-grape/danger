## Danger

[Danger](http://danger.systems) runs during Grape projects' CI process, and gives you a chance to automate common code review chores.

[![Build Status](https://travis-ci.org/ruby-grape/danger.svg?branch=master)](https://travis-ci.org/ruby-grape/danger)

## Table of Contents

- [Setup](#setup)
  - [Set DANGER_GITHUB_API_TOKEN in Travis-CI](#set-danger_github_api_token-in-travis-ci)
  - [Add Danger](#add-danger)
  - [Add Dangerfile](#add-dangerfile)
  - [Add Danger to Travis-CI](#add-danger-to-travis-ci)
  - [Commit via a Pull Request](#commit-via-a-pull-request)
- [License](#license)

## Setup

Enable Danger for a project within the [ruby-grape organization](https://github.com/ruby-grape).

### Add Danger

Add `ruby-grape-danger` to `Gemfile`.

```ruby
gem 'ruby-grape-danger', require: false
```

### Add Dangerfile

Commit a `Dangerfile`, eg. [Grape's Dangerfile](https://github.com/ruby-grape/grape/blob/master/Dangerfile).

```ruby
danger.import_dangerfile(gem: 'ruby-grape-danger')
```

### Commit via a Pull Request

To test things out, make a dummy entry in `CHANGELOG.md` that doesn't match the standard format and make a pull request. Iterate until green.

## License

MIT License. See [LICENSE](LICENSE) for details.

