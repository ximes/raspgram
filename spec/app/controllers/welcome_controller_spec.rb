require 'spec_helper'
require 'mocha/test_unit'

RSpec.describe "/" do
  
  context "Loads the welcome page" do
  	
    before :each do
    	load_settings
      get "/"
    end

    it "returns welcome text" do
      expect(last_response.body).to have_tag('h1', :text => /Welcome to RaspGram./i)
    end

    it "returns contain an email address of the admin" do
      expect(last_response.body).to have_tag('a', :with => {:href => "mailto:test@example.com"} )
    end
  end
end

