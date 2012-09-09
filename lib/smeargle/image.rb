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
        unless corrupt? img
          formatted_images << image_format(img)
        end
      end
      formatted_images
    end

    def detailed_images
      detailed_images = []
      formatted_images.each do |img|
        detailed_images << image_details(img)
      end
      detailed_images
    end

    def image_format img
      if URI(img).relative?
        self.clean_url + img
      else
        img
      end
    end

    def image_details img
      begin
        remote_image = open img
        image = Magick::Image::from_blob(remote_image.read).first
        { url: img, height: image.columns, width: image.rows }
      rescue
        nil
      end
    end

    def filtered_images
      images = detailed_images
      images.reject! { |x| x[:width] < min_width } if min_width
      images.reject! { |x| x[:height] < min_height } if min_height
      images
    end

    def simple_images
      @simple_images ||= formatted_images
    end

    def corrupt? img
      img =~ /\;/
    end

  end
end
