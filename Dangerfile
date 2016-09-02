# --------------------------------------------------------------------------------------------------------------------
# Has any changes happened inside the actual library code?
# --------------------------------------------------------------------------------------------------------------------
has_app_changes = !git.modified_files.grep(/lib/).empty?
has_spec_changes = !git.modified_files.grep(/spec/).empty?

# --------------------------------------------------------------------------------------------------------------------
# You've made changes to lib, but didn't write any tests?
# --------------------------------------------------------------------------------------------------------------------
if has_app_changes && !has_spec_changes
  warn("There're library changes, but not tests. That's OK as long as you're refactoring existing code.", sticky: false)
end

# --------------------------------------------------------------------------------------------------------------------
# You've made changes to specs, but no library code has changed?
# --------------------------------------------------------------------------------------------------------------------
if !has_app_changes && has_spec_changes
  message('We really appreciate pull requests that demonstrate issues, even without a fix. That said, the next step is to try and fix the failing tests!', sticky: false)
end

# --------------------------------------------------------------------------------------------------------------------
# Have you updated CHANGELOG.md?
# --------------------------------------------------------------------------------------------------------------------
changelog.check

# --------------------------------------------------------------------------------------------------------------------
# Don't let testing shortcuts get into master by accident,
# ensuring that we don't get green builds based on a subset of tests.
# --------------------------------------------------------------------------------------------------------------------

(git.modified_files + git.added_files - %w(Dangerfile)).each do |file|
  next unless File.file?(file)
  contents = File.read(file)
  if file.start_with?('spec')
    fail("`xit` or `fit` left in tests (#{file})") if contents =~ /^\w*[xf]it/
    fail("`fdescribe` left in tests (#{file})") if contents =~ /^\w*fdescribe/
  end
end
