# Releasing

There're no particular rules about when to release ruby-grape-danger. Release bug fixes frequently, features not so frequently and breaking API changes rarely.

### Release

Run tests, check that all tests succeed locally.

```
bundle install
rake
```

Check that the last build succeeded in [Travis CI](https://travis-ci.org/ruby-grape/ruby-grape-danger) for all supported platforms.

Increment the version, modify [lib/ruby-grape-danger/version.rb](lib/ruby-grape-danger/version.rb).

*  Increment the third number if the release has bug fixes and/or very minor features, only (eg. change `0.7.1` to `0.7.2`).
*  Increment the second number if the release contains major features or breaking API changes (eg. change `0.7.1` to `0.8.0`).

Change "Next Release" in [CHANGELOG.md](CHANGELOG.md) to the new version.

```
### 0.7.2 (February 6, 2014)
```

Remove the line with "Your contribution here.", since there will be no more contributions to this release.

Commit your changes.

```
git add CHANGELOG.md lib/ruby-grape-danger/version.rb
git commit -m "Preparing for release, 0.7.2."
git push origin master
```

Release.

```
$ rake release

ruby-grape-danger 0.7.2 built to pkg/ruby-grape-danger-0.7.2.gem.
Tagged v0.7.2.
Pushed git commits and tags.
Pushed ruby-grape-danger 0.7.2 to rubygems.org.
```

### Prepare for the Next Version

Add the next release to [CHANGELOG.md](CHANGELOG.md).

```
Next Release
============

* Your contribution here.
```

Commit your changes.

```
git add CHANGELOG.md
git commit -m "Preparing for next release."
git push origin master
```
