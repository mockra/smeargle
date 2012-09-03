require 'open-uri'
require 'nokogiri'
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
      parsed_url = URI.parse url
      if !parsed_url.scheme
        @safe_url ||= 'http://' + url
      end
      @safe_url ||= url
    end

    def response_body
      @response_body ||= Nokogiri::HTML(open safe_url)
    end

  end
end
