# AssertActiveRecord

Helpers for testing ActiveRecords in Assert test suites.  See https://github.com/redding/assert for reference.

## Usage

In general, you should never bundle or require this gem directly.  This gem only houses the framework for testing ActiveRecord using Assert.

Instead you should bundle/require one of the AssertActiveRecord adapter gems.  These adapter gems contain all the specific logic for each major version of ActiveRecord.  These gems, in turn, will require in this gem and use its common framework.

See the usage instructions for the adapter gem you need:

* Rails 4 (ActiveRecord 4): https://github.com/redding/assert-activerecord4#usage

## Installation

See the installation instructions for the adapter gem you need:

* Rails 4 (ActiveRecord 4): https://github.com/redding/assert-activerecord4#installation

If, for some reason, you want to just install this gem directly:

    $ gem install assert-activerecord

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am "Added some feature"`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
