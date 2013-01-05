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
      @formatted_images ||=
        image_collection.reject{ |i| corrupt? i }.
          map { |i| format_image_url i }
    end

    def detailed_images
      @detailed_images ||=
        formatted_images.map { |i| image_details i }
    end

    def format_image_url img
      URI(img).relative? ? "#{clean_url}#{img}" : img
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

    def corrupt? img
      img =~ /\;/
    end

    alias_method :simple_images, :formatted_images

  end
end
