require 'spec_helper'
require 'mocha/test_unit'

RSpec.describe "/api" do
  
  context "when accessing without parameters" do
  	
    before :each do
		  load_settings
    end

    it "should respond" do
      get "/api"
      expect(last_response).to be_ok
    end

    it "should return an empty page" do
      get "/api"
      expect(last_response.body).to eq("{}")
    end

    it "should not receive a message" do
      Message.expects(:new).never
      get "/api"
    end
    it "should not call a response" do
      Response.expects(:new).never
      get "/api"
    end
  end

  context "when accessing with parameters" do

    with_valid_params = {:msg => "Lorem ipsum", :user => "12345678"}
    
    before :each do
      load_settings     
    end

    it "should respond" do
      get_api with_valid_params
      expect(last_response).to be_ok
    end

    it "should return a json response" do
      get_api with_valid_params
      expect(last_response.body).not_to eq("{}")
    end

    it "should setup a connection" do
      Client.expects(:connect)
      get_api with_valid_params
    end

    it "should receive a message" do
      Message.expects(:new).at_least_once
      get_api with_valid_params
    end

    describe "with a valid message" do 
      before do
        @response = Response.new "command"
        Response.any_instance.stubs(:execute!).at_least_once
        Message.any_instance.stubs(:response).returns(@response)
      end

      it "should get a valid response" do
        get_api with_valid_params
        expect(JSON.parse(last_response.body, symbolize_names: true).keys).to contain_exactly(:received, :response)
      end      
    end
    describe "without a valid message" do 
      before do
        @response = nil
      end
      it "shouldn't get a valid response" do
        get_api with_valid_params
        expect(JSON.parse(last_response.body, symbolize_names: true).keys).to contain_exactly(:received)
      end      
    end

  end

  def get_api(params = nil)
    get "/api", params
  end
end