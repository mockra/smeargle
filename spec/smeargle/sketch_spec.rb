require 'spec_helper'

describe Smeargle::Sketch do

  let(:smeargle) { Smeargle::Sketch.new 'google.com' }

  before do
    FakeWeb.register_uri :get, 'http://google.com',
      body: "Google <img src='test.png' />"
  end

  describe 'new' do
    it 'should initialize url' do
      s = Smeargle::Sketch.new 'http://google.com'
      s.url.should == 'http://google.com'
    end

    it 'should set min width/height' do
      s = Smeargle::Sketch.new 'http://google.com',
        min_width: 200, min_height: 250
      s.min_width.should == 200
      s.min_height.should == 250
    end
  end

  describe 'safe_url' do
    it 'should format the url' do
      smeargle.safe_url.should == 'http://google.com'
    end

    it 'should leave the url alone' do
      s = Smeargle::Sketch.new 'http://google.com'
      s.safe_url.should == 'http://google.com'
      s.safe_url.should == s.url
    end
  end

  describe 'response' do
    it 'should have the correct body' do
      smeargle.response_body.css('body').text.
        should =~ /google/i
    end
  end

  describe 'clean_url' do
    it 'should clean up paramaters' do
      s = Smeargle::Sketch.new 'google.com/test/clean?go=now'
      s.clean_url.should == 'http://google.com'
    end
  end

end
