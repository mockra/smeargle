require 'rmagick'

module Smeargle
  module Image

    def images
      @images ||= filtered_images
    end

    def image_collection
      images = []
      response_body.css('img').each do |img|
        images << img['src']
      end
      images.uniq
    end

    def formatted_images
      formatted_images = []
      image_collection.each do |img|
        image = image_format img
        formatted_images << image_details(image)
      end
      formatted_images
    end

    def image_format img
      if URI(img).relative?
        self.safe_url + img
      else
        img
      end
    end

    def image_details img
      remote_image = open img
      image = Magick::Image::from_blob(remote_image.read).first
      { url: img, height: image.columns, width: image.rows }
    end

    def filtered_images
      images = formatted_images
      images.reject! { |x| x[:width] < min_width } if min_width
      images.reject! { |x| x[:height] < min_height } if min_height
      images
    end

  end
end
