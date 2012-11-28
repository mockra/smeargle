# Smeargle [![BuildStatus](https://secure.travis-ci.org/mockra/smeargle.png)](http://travis-ci.org/mockra/smeargle)

Smeargle is an image collection tool that will return an object
containing images from a given URL. Smeargle was designed to be
a lightweight and simple solution for collecting images.

This library does provide some basic logic for helping you find
a suitable image from any given url. Smeargle uses rmagick for
filtering images based on size.

![Smeargle](http://www.toplessrobot.com/smeargle.gif)

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
  Smeargle::Sketch.new 'http://mockra.com', min_width: 200
```

The available options are:

```
  Minimum images dimentions returned
  :min_width, :min_height
```

### Images

Images returned by your URL are included in the images array. Depending
on the number of images included in the body, this could take some time
to run. You may want to have it run in the background.

```
  s = Smeargle::Sketch.new 'google.com'

  # returns an array filtered by provided options
  s.images

  s.images.each do |img|
    img[:url]
    img[:width]
    img[:height]
  end
```

If you're not looking to filter images, and don't need detailed information,
then you can use simple_images. This method returns an array of image
urls, and is faster than the images method.

```
  s = Smeargle::Sketch.new 'google.com'

  s.simple_images.each do |img|
    img  # returns 'http://google.com/test.jpg'
  end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Contact

[david@mockra.com](mailto:david@mockra.com)

[@Mockra_](http://twitter.com/#!/mockra_)

[mockra.com](http://mockra.com)
