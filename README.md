# OfflineGeocoder

A gem for offline reverse geocoding. It uses data from the [GeoNames](http://www.geonames.org/) project.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'offline_geocoder'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install offline_geocoder

## Usage

```ruby
require "offline_geocoder"

geocoder = OfflineGeocoder.new

results = geocoder.search(51.5214588, -0.1729636)

p results
```

The above code will output this:

```ruby
{:lat=>51.51116, :lon=>-0.18426, :name=>"Bayswater", :admin1=>"England", :admin2=>"Greater London", :cc=>"GB", :country=>"United Kingdom"}
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
