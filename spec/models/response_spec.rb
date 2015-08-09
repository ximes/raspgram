require 'spec_helper'
require 'mocha/test_unit'

RSpec.describe Response do

	context "A new response" do
		it "is valid with a command" do
			response = build(:valid_response)
			expect(response).to be_valid
		end
		it "is invalid without a command" do
			response = build(:empty_response)
			expect(response).not_to be_valid
		end
		it "should be executed" do
			response = build(:valid_response)
			expect(response).to respond_to(:execute!)
			response.expects(:system).once
			response.execute!
		end
	end
end
