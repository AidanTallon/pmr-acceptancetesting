# Contains rake tasks to make it easier to run cucumber from terminal

require 'cucumber'
require 'cucumber/rake/task'
require 'rake/clean'

# rake clean can be used to clear out old reports and screenshots
CLEAN.include('results/rerun.txt',
              'results/report.html',
              'results/screenshots/*.*',
              'logs/*.*')

# Each profile is given a rake task
profiles = YAML.load(File.open(File.join(Dir.pwd, 'cucumber.yml')))
profiles.each do |name, value|
  desc "Run profile #{name}: #{value}"
  Cucumber::Rake::Task.new name.to_sym, "Run profile #{name}: #{value}" do |t|
    t.profile = name
  end
end

# Creates an HTML report
desc "Runs all features and outputs to HTML and rerun.txt"
Cucumber::Rake::Task.new :report, "Output an HTML report and rerun.txt file to reports/" do |t|
  t.profile = 'default'
  t.cucumber_opts = "--format html --out results/test_report.html --format rerun --out results/rerun.txt"
end

# Reruns tests that failed on the previous run
desc "Rerun tests output by rake:output"
Cucumber::Rake::Task.new :rerun, "Rerun failed scenarios from 'report' rake task" do |t|
  t.profile = 'default'
  t.cucumber_opts = "@results/rerun.txt -r features"
end

# Run scenarios by tag
desc "Run with tags"
Cucumber::Rake::Task.new :t, "Run 'all' profile, pass tags as args." do |t|
  t.profile = 'all'
  ARGV.shift # Ignore the first value in ARGV (it will be the rake task name)
  options = "--format rerun --out results/rerun.txt "
  ARGV.each do |tag|
    options.concat("-t #{tag} ") if tag =~ /^(?:@|~)/ # Only add arguments beginning with '@' or '~'
  end
  t.cucumber_opts = options
end

desc "Run production tasks"
Cucumber::Rake::Task.new :production, "Run only tasks tagged with production." do |t|
  t.profile = 'clean_features'
  t.cucumber_opts = "--format pretty --format html --out results/report.html"
end

desc "Run smoke tasks"
Cucumber::Rake::Task.new :smoke, "Run only tasks tagged with smoke." do |t|
  t.profile = 'smoke_features'
  t.cucumber_opts = "--format pretty --format html --out results/report.html"
end

desc "Run pry instance in test environment"
Cucumber::Rake::Task.new :pry, "Run pry instance in test environment." do |t|
  t.cucumber_opts = "-t @pry"
end

# Generate HTML docs from README
task :generate_docs, "Generate HTML Documentation from the README.html" do
  system 'ruby ./bin/generate_docs_from_readme.rb'
end

# Show help message
task :help, "Show additional flags available" do
  message = <<-MESSAGE

Run 'rake -T' to see the available rake tasks.
Run 'rake generate_docs' to generate an HTML readme in /docs.
Run 'rake clean' to clear out generated logs and reports.
-----------------------------------------------------------
Optional flags to pass into the Environment:

  CONFIG=ci, ft, uat, or rc (defaults to 'ci')
  BROWSER=firefox, chrome or ie (defaults to 'chrome')
  TAGS=@foo
-----------------------------------------------------------

Example:

  rake t @wip ~@manual CONFIG=uat BROWSER=ie

Result:

  Executes all tests tagged with @wip except those
    tagged with @manual, and sets two environment
    variables: CONFIG and BROWSER.

-----------------------------------------------------------

  MESSAGE
  puts message
end
