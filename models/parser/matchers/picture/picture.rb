module Parser
	class Picture < Matcher
		def initialize
			@word = "system pic"
		end
		def callback
			Response.new(Telegram.msg "Try this one:", @from).execute!
			
			img = "statuses/shot_#{Time.now.to_i}.png"
			system("raspistill -v -w 1200 -h 800 -q 75 -o #{img}")

			Response.new(Telegram.send_picture(img, @from)).execute!
			
			@response = "Do you like it?"
			super
		end
	end
end