require 'spec_helper'

describe Smeargle::Image do

  let(:smeargle) { Smeargle::Sketch.new 'google.com' }

  before do
    smeargle.stub!(:image_details).and_return(
      { url: 'test.png', height: 10, width: 10 })

    FakeWeb.register_uri :get, 'http://google.com',
      body: "Google <img src='/test.png' /> <img src='/test.png' />
      <img src='/test.png;script' />"
  end

  describe 'images' do
    it 'returns an array' do
      smeargle.images.should be_a Array
    end

    it 'contains the sample image' do
      smeargle.images.first[:url].should =~ /test\.png/i
    end

    it 'contains hashes' do
      smeargle.images.first.should be_a Hash
    end
  end

  describe 'format_image_url' do
    it 'formats relative paths' do
      e = smeargle.format_image_url '/test.png'
      e.should == 'http://google.com/test.png'
    end

    it 'does not format absolute paths' do
      e = smeargle.format_image_url 'http://google.com/test.png'
      e.should == 'http://google.com/test.png'
    end
  end

  describe 'formatted images' do
    it 'returns an array of formatted urls' do
      e = smeargle.formatted_images
      e.first.should == 'http://google.com/test.png'
    end

    it 'excludes corrupted images' do
      e = smeargle.formatted_images
      e.count.should == 1
    end
  end

  describe 'detailed_images' do
    it 'returns an array of hashes' do
      e = smeargle.detailed_images
      e.first.should be_a Hash
    end
  end

  describe 'image_collection' do
    it 'does not contain duplicates' do
      smeargle.image_collection.count.should == 2
    end
  end

  describe 'filtered_images' do
    it 'filters images on height' do
      s = Smeargle::Sketch.new 'google.com', min_width: 20
      s.stub!(:image_details).and_return(
        { url: 'test.png', height: 10, width: 10 })
      s.filtered_images.count.should == 0
    end
  end

  describe 'simple_images' do
    it 'contains an array of urls' do
      s = Smeargle::Sketch.new 'google.com'
      s.simple_images.first.should =~ /test\.png/
    end
  end

  describe 'corrupt?' do
    it 'returns true for corrupt url' do
      e = smeargle.corrupt? 'http:/google.com/test;test.png'
      e.should be_true
    end
  end

end
