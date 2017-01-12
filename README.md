# Pokken Matchup Recorder Acceptance Testing

You can view this README as an HTML document by running `rake generate_docs` and visiting ./docs/index.html

Acceptance testing for the Pokken Matchup Recorder app using Cucumber and Watir.
github: https://github.com/AidanTallon/PokkenMatchupRecorder
live app: https://pokken-matchup-recorder.herokuapp.com

# Using these tests

`bundle exec rake production` runs tests for checking all of system health.
`bundle exec rake smoke` runs smoke tests for system.

# Test Setup

## Strategy

Test all aspects of the app accessing the UI elements with Watir. All aspects should be fully automated where possible.

## Features

The acceptance tests should be high-level and detail behaviour of the system.

## Page Objects & the App class

TODO

## Step Definitions

Describes the actions to be taken in a test.
Logic should be handled within an appropriate page object, so that the step definitions can be kept as 'skinny' as possible.

## Project Structure

TODO

## Tagging Policy

`@manual`
`@wip`
`@failing`
`@off`

TODO

## Rake Tasks

TODO

## Using IRB inside the application

TODO

# CI

Codeship runs the following commands on every push to github
```
rvm use $(cat .ruby-version)
bundle install

bundle exec rake production
```


