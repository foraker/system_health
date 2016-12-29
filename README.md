# System Health

The System Health gem can be added to your Rails application to provide
a convenient way to regularly look for bad data or other system health
indicators.

## Installation

Add this line to your application's Gemfile:

    gem 'system_health'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install system_health

and then...

1. Create your monitor classes

  All monitoring classes require a public instance method named `description`.
  This method should return a string describing the bad data condition that is
  being tested.

## Generic monitoring class

  For example, in lib/system_health/monitors/bad_data.rb create:

  ```ruby
  module SystemHealth
    module Monitors
      class BadData < Base
        def description
          'Bad data was discovered'
        end

        private

        def bad_data?
          # return true from this method if there is bad data
        end
      end
    end
  end
  ```

  define a private instance method `bad_data?` that should return true
  when bad data exists.

## SQL monitoring class

  For example, in lib/system_health/monitors/bad_sql_data.rb create:

  ```ruby
  module SystemHealth
    module Monitors
      class BadSqlData < Sql
        def description
          'Bad data was discovered through a SQL query'
        end

        private

        def sql
          <<-SQL
            SELECT *
            FROM some_table
            WHERE bad_data is true
          SQL
        end
      end
    end
  end
  ```

  this type of monitor requires an additional private instance method
  named `sql`.  This SQL statement should return rows for any data
  integrity problem.  I.e. no rows means no problem.  Rows returned means
  there is a problem.


2. create an initializer in config/initializers/system_health.rb

  ```ruby
  SystemHealth.configure do |config|
    config.monitor_classes = [
      SystemHealth::Monitors::BadData,
      SystemHealth::Monitors::BadSqlData
    ]
  end
  ```

## Usage

The System Health gem exposes a monitoring class `SystemHealth::Monitor` that
can be used to test for all system health issues with the following
methods:

```ruby
mon = SystemHealth::Monitor.new
mon.error_messages
mon.error_count
```

## To do?

1. Add concept of notifiers to make it more seamless to email or report
   on system health issues.
2. Add monitor classes so different classes can be run at different
   times and with different frequency.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/system_health/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## About Foraker Labs

[![Foraker Logo](http://assets.foraker.com/attribution_logo.png)](https://www.foraker.com/)

[Foraker Labs](https://www.foraker.com/) builds exciting web and mobile apps in Boulder, CO. Our work powers a wide variety of businesses with many different needs. We love open source software, and we're proud to contribute where we can. Interested to learn more? [Contact us today](https://www.foraker.com/contact-us).

This project is maintained by Foraker Labs. The names and logos of Foraker Labs are fully owned and copyright Foraker Design, LLC.
