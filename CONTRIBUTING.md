Contributing to Grape's Dangerfile
==================================

You're encouraged to submit [pull requests](https://github.com/ruby-grape/danger/pulls), [propose features and discuss issues](https://github.com/ruby-grape/danger/issues). When in doubt, ask a question in the [Grape Google Group](http://groups.google.com/group/ruby-grape).

#### Fork the Project

Fork the [project on Github](https://github.com/ruby-grape/danger) and check out your copy.

```
git clone https://github.com/contributor/grape.git
cd grape
git remote add upstream https://github.com/ruby-grape/danger.git
```

#### Create a Topic Branch

Make sure your fork is up-to-date and create a topic branch for your feature or bug fix.

```
git checkout master
git pull upstream master
git checkout -b my-feature-branch
```

#### Update Dangerfile

Implement your feature in Dangerfile.

Ruby style is enforced with [Rubocop](https://github.com/bbatsov/rubocop), run `bundle exec rubocop -a`, then `bundle exec rubocop` and fix any style issues highlighted.

Make sure that `bundle exec rake` completes without errors.

#### Update Changelog

Add a line to [CHANGELOG](CHANGELOG.md). Make it look like every other line, including your name and link to your Github account.

#### Commit Changes

Make sure git knows your name and email address:

```
git config --global user.name "Your Name"
git config --global user.email "contributor@example.com"
```

Writing good commit logs is important. A commit log should describe what changed and why.

```
git add ...
git commit
```

#### Push

```
git push origin my-feature-branch
```

#### Make a Pull Request

Go to https://github.com/contributor/danger and select your feature branch. Click the 'Pull Request' button and fill out the form. Pull requests are usually reviewed within a few days.

#### Rebase

If you've been working on a change for a while, rebase with upstream/master.

```
git fetch upstream
git rebase upstream/master
git push origin my-feature-branch -f
```

#### Update CHANGELOG Again

Update the [CHANGELOG](CHANGELOG.md) with the pull request number. A typical entry looks as follows.

```
* [#123](https://github.com/ruby-grape/danger/pull/123): Reticulated splines - [@contributor](https://github.com/contributor).
```

Amend your previous commit and force push the changes.

```
git commit --amend
git push origin my-feature-branch -f
```

#### Check on Your Pull Request

Go back to your pull request after a few minutes and see whether it passed muster with Travis-CI. Everything should look green, otherwise fix issues and amend your commit as described above.

#### Be Patient

It's likely that your change will not be merged and that the nitpicky maintainers will ask you to do more, or fix seemingly benign problems. Hang on there!

#### Thank You

Please do know that we really appreciate and value your time and work. We love you, really.
