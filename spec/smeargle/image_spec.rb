require 'spec_helper'

describe Smeargle::Image do

  let(:smeargle) { Smeargle::Sketch.new 'google.com' }

  before do
    smeargle.stub!(:image_details).and_return(
      { url: 'test.png', height: 10, width: 10 })

    FakeWeb.register_uri :get, 'http://google.com',
      body: "Google <img src='/test.png' /> <img src='/test.png' />"
  end

  describe 'images' do
    it 'should return an array' do
      smeargle.images.should be_a Array
    end

    it 'should contain the sample image' do
      smeargle.images.first[:url].should =~ /test\.png/i
    end

    it 'should contain hashes' do
      smeargle.images.first.should be_a Hash
    end
  end

  describe 'image_format' do
    it 'should format relative paths' do
      e = smeargle.image_format '/test.png'
      e.should == 'http://google.com/test.png'
    end

    it 'should not format absolute paths' do
      e = smeargle.image_format 'http://google.com/test.png'
      e.should == 'http://google.com/test.png'
    end
  end

  describe 'formatted images' do
    it 'should return an array of formatted urls' do
      e = smeargle.formatted_images
      e.first.should == 'http://google.com/test.png'
    end
  end

  describe 'detailed_images' do
    it 'should return an array of hashes' do
      e = smeargle.detailed_images
      e.first.should be_a Hash
    end
  end

  describe 'image_collection' do
    it 'should not contain duplicates' do
      smeargle.image_collection.count.should == 1
    end
  end

  describe 'filtered_images' do
    it 'should filter images on height' do
      s = Smeargle::Sketch.new 'google.com', min_width: 20
      s.stub!(:image_details).and_return(
        { url: 'test.png', height: 10, width: 10 })
      s.filtered_images.count.should == 0
    end
  end

  describe 'simple_images' do
    it 'should contain an array of urls' do
      s = Smeargle::Sketch.new 'google.com'
      s.simple_images.first.should =~ /test\.png/
    end
  end

  describe 'corrupt?' do
    it 'should return true for corrupt url' do
      e = smeargle.corrupt? 'http:/google.com/test;test.png'
      e.should be_true
    end
  end

end
