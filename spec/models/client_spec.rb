require 'spec_helper'
require 'mocha/test_unit'

RSpec.describe Client do

	context "A new client" do
		describe "if a connection doesn't exist" do
			xit "should create a new connection" do
				IO.any_instance.expects(:popen).returns(true)
				IO.any_instance.stubs(:readlines).returns("No Sockets found")
				@connection = Client.new
				@connection.expects(:system).once
			end
		end

		describe "if a connection does exist" do
			xit "shouldn't create a new connection" do
				IO.stubs(:popen).returns("Socket name")
				Client.expects(:system).never
				connection = Client.new
			end
		end
	end
end