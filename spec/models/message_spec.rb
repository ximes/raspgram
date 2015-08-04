require 'spec_helper'
require 'mocha/test_unit'

RSpec.describe Message do

	valid_attributes = {content: "Lorem ipsum", to: "12345678"}
	
	context "A new message" do
		it "is valid with a msg and userid" do
			message = Message.new(valid_attributes)
			expect(message).to be_valid
		end
		it "is invalid without a msg" do
			message = Message.new(to: "12345678")
			expect(message).not_to be_valid
		end
		it "is invalid without a userid" do
			message = Message.new(content: "Lorem ipsum")
			expect(message).not_to be_valid
		end
		it "should have a user to" do
			message = Message.new valid_attributes
			expect(message.to).to eq(valid_attributes[:to])
		end
		it "should have a user to" do
			message = Message.new valid_attributes
			expect(message.content).to eq(valid_attributes[:content])
		end
	end
	context "A message" do
		before :each do 
			@message = Message.new valid_attributes
		end
		describe "with valid content" do
			before do
				@message.stubs(:parse?).returns(true)
			end
			it "should return a response" do
				expect(@message.parse!).to be_a Response
			end
		end
		describe "with no valid content" do
			before do
				@message.stubs(:parse?).returns(false)
			end
			it "shouldn't return a response" do
				expect(@message.parse!).to eq(nil)
			end
		end

		xit "should match a language contruct"
		xit "should take part in a conversation"

	end
end
