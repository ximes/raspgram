module Parser
	class Picture < Matcher
		def initialize
			@word = "system pic"
		end
		def parse(input, from)
			if /^#{@word}/i.match input
				@input = input
				@from = from
			end
		end
		def callback
			Response.new(Telegram.msg "Try this one:", @from).execute!
			
			img = "statuses/shot_#{Time.now.to_i}.png"
			system("raspistill -v -w 1200 -h 800 -q 75 -o #{img}")

			Response.new(Telegram.send_picture(img, @from)).execute!
			
			Telegram.msg "Do you like it?", @from
		end
	end
end