# Pokken Matchup Recorder Acceptance Testing

You can view this README as an HTML document by running `rake generate_docs` and visiting ./docs/index.html

Acceptance testing for the Pokken Matchup Recorder app using Cucumber and Watir.
github: https://github.com/AidanTallon/PokkenMatchupRecorder
live app: https://pokken-matchup-recorder.herokuapp.com

# Using these tests

`bundle exec rake production` runs tests for checking all of system health.
`bundle exec rake smoke` runs smoke tests for system.

`bundle exec rake production CONFIG=local` runs production tests on localhost:5000

# Test Setup

## Strategy

Test all aspects of the app accessing the UI elements with Watir. All aspects should be fully automated where possible.

## Features

The acceptance tests should be high-level and detail behaviour of the system.

## Page Objects & the App class

### App

Singleton class that supplies page objects to use in step definitions. Use like `App.index_page`.

```ruby
class App
  def self.browser=(browser)
    @browser = browser
  end

  def self.browser
    @browser
  end

  def self.method_missing(method_name, *_arguments, &_block)
    # Initializes App.page_object if it doesn't already exist
    if method_name =~ /(.+)_page/
      @pages ||= {}
      class_name = method_name.to_s.split('_').collect(&:capitalize).join
      @pages[method_name] || @pages[method_name] = Object.const_get(class_name).new(@browser)
    else
      super
    end
  end
  ...
end
```

### Page Objects

Page Objects are where you write the code required to run the tests. All interactions with pages should be abstracted to these Page Objects in a clear and readable manner. Page Object class names are written in `UpperCamelCase`, and the ruby file is the same name converted to `snake_case.rb`. Page Objects are called from the App class using `snake_case`, e.g. `App.index_page`.

```ruby
class IndexPage < GenericPage
  def initialize(browser)
    super browser
    @url = EnvConfig.base_url
    @trait = @browser.div(tid: 'toolbar')
  end
  ...
end
```

Page Objects inherit from the GenericPage class. When `@url` and `@trait` instance variables are defined in the `initialize` method, the Page Object can call the methods `visit` and `on_page?`. When creating a new Page Object class, a call **MUST** be made to super passing it a browser argument.
The `@trait` instance variable should be a Watir Browser page element that is **unique** to the page.
The `@url` instance variable should use `EnvConfig.base_url` to supply the beginning url, followed by the path of the page.

### GenericPage

The GenericPage class contains functionality that should be common among all pages.

```ruby
class GenericPage
  def initialize(browser)
    @browser = browser
  end

  def visit
    @browser.goto @url
    raise "Not on #{self.class.name} page" unless on_page?
  end

  def on_page?
    begin
      Watir::Wait.until(timeout: 10) { @trait.exists? }
      return true
    rescue
      return false
    end
  end
end
```

Above is the entirety of the current GenericPage class at this time of writing. It supplies `visit` and `on_page?` methods.
`on_page?` returns a boolean value indicating whether you are on the page, using the `@trait` of that page. If you wish to raise an exception when not on a specific page, use `raise unless App.index_page.on_page?` in the step definition.

## Step Definitions

Describes the actions to be taken in a test.
Logic should be handled within an appropriate page object, so that the step definitions can be kept as 'skinny' as possible.

## Project Structure

```text
|- config.yml                 General configuration settings
|- cucumber.yml               Cucumber profiles
|- Gemfile
|- Gemfile.lock
|- Rakefile                   Rake tasks to execute tests
|- README.md                  This file
|- lib/
|   `- env_config.rb          Class to expose config.yml
|- features/                  Features go in this dir
|   |- step_definitions/      Step definitions
|   `- support/
|       |- test.feature       Feature to run pry in test instance
|       |- test_steps.rb      Step to run pry in test instance
|       |- env.rb             Environment settings
|       |- hooks.rb           Hooks and setup code
|       |- pages/             Page objects
|       `- helpers/           Helper method
|           |- watir.rb       Extend Watir to use custom attributes
|- bin/
|   `- generate_docs_from_readme.rb
`- results/                   Screenshots and HTML report
    `- screenshots
```

## Tagging Policy

`@manual` Will not be run.
`@wip`  Will not be run.
`@failing`  Will not be run in default profile.
`@off`  Will not be run.
`@smoke` Will be run in rake smoke.

## Rake Tasks

`rake generate_docs` converts the README.md file into an HTML document.
`rake clean` clears out the logs and results direectories. **Run this before committing** to avoid polluting the CI artefacts with old screenshots and reports.
`rake production` used by Codeship to execute full automation suite.
`rake smoke` runs only @smoke features.
`rake wip` runs only @wip features.
`rake t @sometag` runs features with that specific tag.
`rake help` shows details of the available tasks.

## Using pry inside the application

A test feature and scenario exist to allow you to access pry inside the application. Run:

```bash
bundle exec rake pry
```

You'll then end up inside a pry instance, with the test environment correctly loaded.

You can also start a pry instance by adding `binding.pry` anywhere in the code. **PLEASE** make sure to remove these when you are done prying!

# CI

Codeship runs the following commands on every push to github
```
rvm use $(cat .ruby-version) --install
gem install bundler
bundle install

bundle exec rake production
```


