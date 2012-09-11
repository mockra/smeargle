module Smeargle
  class Sketch

    include Smeargle::Image

    attr_accessor :url, :min_width, :min_height

    def initialize url, args = {}
      @url = url
      args.each do |key, value|
        send "#{key}=", value
      end
    end

    def safe_url
      parsed_url = URI.parse url
      if !parsed_url.scheme
        @safe_url ||= 'http://' + url
      else
        @safe_url ||= url
      end
    end

    def response_body
      @response_body ||= Nokogiri::HTML(open safe_url)
    end

    def clean_url
      @clean_url ||=
        URI(safe_url).scheme +
        '://' + URI(safe_url).host
    end

  end
end
