require 'spec_helper'

describe Smeargle::Image do

  let(:smeargle) { Smeargle::Sketch.new 'google.com' }

  before do
    FakeWeb.register_uri :get, 'http://google.com',
      :body => "Google <img src='test.png' />"
  end

  describe 'images' do
    it 'should return an array' do
      smeargle.images.should be_a Array
    end

    it 'should contain the sample image' do
      smeargle.images.first.should =~ /test\.png/i
    end
  end

end
