module Smeargle
  module Image

    def images
      collect_images
    end

    def collect_images
      images = []
      response_body.css('img').each do |img|
        images << img['src']
      end
      @collect_images ||= images
    end

  end
end
