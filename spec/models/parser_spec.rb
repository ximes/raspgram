require 'spec_helper'
require 'mocha/test_unit'

RSpec.describe Parser do
	
	context "should parse a message" do
		xit "test" do
			message = build(:valid_message)
			expect(message).to be_valid
		end
		xit "is invalid without a msg" do
			message = build(:message, content: nil)
			expect(message).not_to be_valid
		end
		xit "is invalid without a userid" do
			message = build(:message, to: nil)
			expect(message).not_to be_valid
		end
		before do
			@message = build(:valid_message)
		end
		xit "should have a user to" do
			expect(@message.to).to eq("12345678")
		end
		xit "should have a content" do
			expect(@message.content).to eq("Lorem ipsum")
		end
		xit "could have errors" do
			expect(@message).to respond_to(:has_errors?)
		end
		xit "could have responses" do
			expect(@message).to respond_to(:has_valid_response?)
		end
		xit "could respond to messages" do
			expect(@message).to respond_to(:respond)
		end
	end
end
