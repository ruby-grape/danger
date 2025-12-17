# frozen_string_literal: true

require 'ruby-grape-danger'
require 'English'

# This Dangerfile provides automatic danger report export and standard checks for Grape projects.
# Other projects can import this via: danger.import_dangerfile(gem: 'ruby-grape-danger')
# to get automatic reporting with their own custom checks.

# --------------------------------------------------------------------------------------------------------------------
# Automatically export danger report when Dangerfile finishes
# --------------------------------------------------------------------------------------------------------------------
at_exit do
  # Only skip if there's an actual exception (not SystemExit from danger calling exit)
  next if $ERROR_INFO && !$ERROR_INFO.is_a?(SystemExit)

  # Try to export the danger report
  begin
    puts "DEBUG at_exit: Trying to find status_report"
    puts "DEBUG at_exit: defined?(Danger) = #{defined?(Danger)}"
    puts "DEBUG at_exit: Danger.class = #{Danger.class}" if defined?(Danger)

    # Try multiple ways to access the status report
    danger_report = nil

    # Method 1: Try Danger.current_dangerfile
    if defined?(Danger) && Danger.respond_to?(:current_dangerfile)
      puts "DEBUG at_exit: Danger.current_dangerfile exists"
      danger_report = Danger.current_dangerfile.status_report
    end

    # Method 2: Try via ObjectSpace to find active dangerfile
    unless danger_report
      puts "DEBUG at_exit: Looking for Danger::Dangerfile via ObjectSpace"
      ObjectSpace.each_object(Danger::Dangerfile) do |df|
        danger_report = df.status_report
        break
      end
    end

    if danger_report
      puts "DEBUG at_exit: Found danger_report, exporting"
      reporter = RubyGrapeDanger::Reporter.new(danger_report)
      reporter.export_json(
        ENV.fetch('DANGER_REPORT_PATH', nil),
        ENV.fetch('GITHUB_EVENT_PATH', nil)
      )
    else
      puts "DEBUG at_exit: Could not find danger_report"
    end
  rescue => e
    # Log any errors but don't fail the entire exit
    puts "ERROR at_exit: #{e.class} - #{e.message}"
    puts e.backtrace.join("\n")
  end
end

# --------------------------------------------------------------------------------------------------------------------
# Has any changes happened inside the actual library code?
# --------------------------------------------------------------------------------------------------------------------
has_app_changes = !git.modified_files.grep(/lib/).empty?
has_spec_changes = !git.modified_files.grep(/spec/).empty?

# --------------------------------------------------------------------------------------------------------------------
# You've made changes to lib, but didn't write any tests?
# --------------------------------------------------------------------------------------------------------------------
warn("There're library changes, but not tests. That's OK as long as you're refactoring existing code.", sticky: false) if has_app_changes && !has_spec_changes

# --------------------------------------------------------------------------------------------------------------------
# You've made changes to specs, but no library code has changed?
# --------------------------------------------------------------------------------------------------------------------
if !has_app_changes && has_spec_changes
  message('We really appreciate pull requests that demonstrate issues, even without a fix. That said, the next step is to try and fix the failing tests!', sticky: false)
end

# --------------------------------------------------------------------------------------------------------------------
# Have you updated CHANGELOG.md?
# --------------------------------------------------------------------------------------------------------------------
changelog.check!

# --------------------------------------------------------------------------------------------------------------------
# Do you have a TOC?
# --------------------------------------------------------------------------------------------------------------------
toc.check!

# --------------------------------------------------------------------------------------------------------------------
# Don't let testing shortcuts get into master by accident,
# ensuring that we don't get green builds based on a subset of tests.
# --------------------------------------------------------------------------------------------------------------------

(git.modified_files + git.added_files - %w[Dangerfile]).each do |file|
  next unless File.file?(file)

  contents = File.read(file)
  if file.start_with?('spec')
    fail("`xit` or `fit` left in tests (#{file})") if contents =~ /^\w*[xf]it/
    fail("`fdescribe` left in tests (#{file})") if contents =~ /^\w*fdescribe/
  end
end
