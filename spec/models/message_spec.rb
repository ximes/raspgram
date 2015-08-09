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
		before do
			@message = Message.new valid_attributes
		end
		it "should have a user to" do
			expect(@message.to).to eq(valid_attributes[:to])
		end
		it "should have a content" do
			expect(@message.content).to eq(valid_attributes[:content])
		end
		it "could have errors" do
			expect(@message).to respond_to(:has_errors?)
		end
		it "could have responses" do
			expect(@message).to respond_to(:has_valid_response?)
		end
		it "could respond to messages" do
			expect(@message).to respond_to(:respond)
		end
	end
	context "A message" do
		describe "with valid content" do
			before do 
				@response = Response.new "command"
				@message = Message.new valid_attributes.merge({ response: @response })
			end
			it "should return a response" do
				@response.expects(:execute!).at_least_once
				@message.respond
				expect(@message.response).to be_a Response
			end
			it "should return no errors" do
				expect(@message.errors).to be_empty
			end

		end
		describe "with no valid content" do
			before do
				@message = Message.new valid_attributes
			end
			it "shouldn't return a response" do
				expect(@message.response).to be_nil
				Response.expects(:execute!).never
				expect(@message.has_valid_response?).to be_falsy
			end
			it "should have errors" do
				expect(@message.errors.size).to be > 0
			end
		end

		xit "should match a language contruct"
		xit "should take part in a conversation"

	end
end
