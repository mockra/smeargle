require 'spec_helper'

describe Smeargle::Sketch do

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
      s = Smeargle::Sketch.new 'google.com'
      s.safe_url.should == 'http://google.com'
    end

    it 'should leave the url alone' do
      s = Smeargle::Sketch.new 'http://google.com'
      s.safe_url.should == 'http://google.com'
      s.safe_url.should == s.url
    end
  end

end
