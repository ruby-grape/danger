## Danger

[Danger](http://danger.systems) runs during Grape projects' CI process, and gives you a chance to automate common code review chores.

[![Build Status](https://travis-ci.org/ruby-grape/danger.svg?branch=master)](https://travis-ci.org/ruby-grape/danger)

### Setup

Enable Danger for a project within the [ruby-grape organization](https://github.com/ruby-grape).

#### Set DANGER_GITHUB_API_TOKEN in Travis-CI

In Travis-CI, choose _Settings_ and add `DANGER_GITHUB_API_TOKEN` in _Environment Variables_. Set the value to the API key for the [grape-bot](https://github.com/grape-bot) user, look in [this build log](https://travis-ci.org/ruby-grape/danger/builds/148579641) for its value.

#### Add Danger

Add `ruby-grape-danger` to `Gemfile`.

```ruby
gem 'ruby-grape-danger', '~> 0.1.0', require: false
```

#### Add Dangerfile

Commit a `Dangerfile`, eg. [Grape's Dangerfile](https://github.com/ruby-grape/grape/blob/master/Dangerfile).

```ruby
danger.import_dangerfile(gem: 'ruby-grape-danger')
```

#### Add Danger to Travis-CI

Add Danger to `.travis.yml`, eg. [Grape's Travis.yml](https://github.com/ruby-grape/grape/blob/master/.travis.yml).

```yaml
matrix:
  include:
    - rvm: 2.3.1
      script:
        - bundle exec danger
```

#### Commit via a Pull Request

To test things out, make a dummy entry in `CHANGELOG.md` that doesn't match the standard format and make a pull request. Iterate until green.

## License

MIT License. See [LICENSE](LICENSE) for details.

