# System Health

The System Health gem can be added to your Rails application to provide
a convenient way to regularly look for bad data or other system health
indicators.  It provides a single endpoint that will generate and error
count and enumerate error messages.  This count and the messages can be
collected by external monitoring tools the look for the HTTP status code
(200 when there are no errors or 500 when there is at least one error)
and/or inspect the JSON payload that is returned.

## Installation

Add this line to your application's Gemfile:

    gem 'system_health'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install system_health

and then...

1. create an initializer in config/initializers/system_health.rb

  ```ruby
  SYSTEM_HEALTH_MONITOR_CLASSES = [
    SystemHealth::Monitors::BadData
  ]
  ```

  This should define the SYSTEM_HEALTH_MONITOR_CLASSES array with all
  your monitor classes.  There can be as many monitor classes as you wish.

2. Create your monitor classes

  In lib/system_health/monitors/bad_data.rb create:

  ```ruby
  module SystemHealth
    module Monitors
      class BadData < Base
        def error_messages
          ['some error message here'] if bad_data?
        end

        private

        def bad_data?
          # logic here
        end
      end
    end
  end
  ```

  each monitor should define a public instance method for `error_messages`
  as an array.  If that array is empty then the data is good.  When the
  data is bad, one or more error messages can be placed in that array.
  That is it!

3. Define the environment variables

  For applications hosted on Heroku, this might be something like:

  ```bash
  heroku config:add SYSTEM_HEALTH_MONITOR_USERNAME=somenamehere
  heroku config:add SYSTEM_HEALTH_MONITOR_PASSWORD=somesecrethere
  ```

  on other environments, you'll need to define these elsewhere.

## Usage

The System Health gem exposes a single controller endpoint at:
yourapp://system_health/monitor

It will return a 200 HTTP status code if there are no errors and a 500
HTTP status code if there are any errors.  It also returns a JSON
payload with data like this:

```json
{
  error_count: 0,
  messages: [ ]
}
```

## To do?

1. Consider how to deal with long running monitors that may fail with
   page load limits (e.g. Heroku's 30 second timeout)
2. Add ability to run different health monitors at different times or
   possibly call monitors individually
3. Add the ability to generate error notifications directly from System
   Health instead of relying on external monitoring tools to send these

## Contributing

1. Fork it ( https://github.com/[my-github-username]/system_health/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
