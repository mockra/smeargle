require 'net/http'
require 'uri'
require "smeargle/image"

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
      parsed_url = URI.parse self.url
      if !parsed_url.scheme
        @safe_url ||= 'http://' + self.url
      end
      @safe_url ||= self.url
    end

  end
end
