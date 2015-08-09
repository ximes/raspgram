require 'spec_helper'
require 'mocha/test_unit'

RSpec.describe Response do

	valid_attributes = "command"
	
	context "A new response" do
		it "is valid with a command" do
			response = Response.new(valid_attributes)
			expect(response).to be_valid
		end
		it "is invalid without a command" do
			response = Response.new
			expect(response).not_to be_valid
		end
		it "should be executed" do
			response = Response.new(valid_attributes)
			expect(response).to respond_to(:execute!)
			response.expects(:system).once
			response.execute!
		end
	end
end
