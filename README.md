[![Build Status](https://travis-ci.org/sildur/offline_geocoder.svg)](https://travis-ci.org/sildur/offline_geocoder) 
[![Code Climate](https://codeclimate.com/github/sildur/offline_geocoder/badges/gpa.svg)](https://codeclimate.com/github/sildur/offline_geocoder)
[![Gem Version](https://badge.fury.io/rb/offline_geocoder.svg)](https://badge.fury.io/rb/offline_geocoder)
![Gem](https://img.shields.io/gem/dt/offline_geocoder)

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

Alternatively, you can use named parameters when searching:

```ruby
results = geocoder.search(lat: 51.5214588, lon: -0.1729636)
```

### Searching for names or attributes

You can search for names, countries and such. The first result will be
returned.

Searches are case sensitive and must match entirely. e.g. "York" will
not find "New York", and "Cote dIvoire" will not match "Cote d'Ivoire".

```ruby
require "offline_geocoder"
geocoder = OfflineGeocoder.new
aus = geocoder.search(name: "Bayswater")
p aus
gb = geocoder.search(name: "Bayswater", country: "United Kingdom")
p gb
```

The above code will output this:

```ruby
{:lat=>-37.85, :lon=>145.26667, :name=>"Bayswater", :admin1=>"Victoria", :admin2=>"Knox", :cc=>"AU", :country=>"Australia"}
{:lat=>51.51116, :lon=>-0.18426, :name=>"Bayswater", :admin1=>"England", :admin2=>"Greater London", :cc=>"GB", :country=>"United Kingdom"}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contact Me

If you find any **bugs** or have a **problem** while using this library, please [open an issue](https://github.com/sildur/offline_geocoder/issues/new) in this repo (or a pull request :)).
