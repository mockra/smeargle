# Smeargle

Smeargle is an image collection tool that will return an object
containing images from a given URL. Smeargle was designed to be
a lightweight and simple solution for collecting images. This library
does provide some basic logic for helping you find a suitable image from
any given url.

## Installation

Add this line to your application's Gemfile:

    gem 'smeargle'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install smeargle

## Usage

### Getting Started

When initializing a smeargle object, you're able to provide a variety of
options to help with image selection.
```
  # Initialize a collection with a minimum image width of 200
  Smeargle::Sketch.new 'http://mockra.com', :min_width => 200
```

The available options are:
```
  Minimum images dimentions returned
  :min_width, :min_height

  Include open graph images
  :open_graph
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
