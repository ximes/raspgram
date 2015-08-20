module Parser
	class Status < Matcher
		def initialize
			@word = "system status"
		end
		def parse(input, from)
			if /^#{@word}/i.match input
				@input = input
				@from = from
			end
		end
		def callback
			Telegram.msg "Online", @from
		end
	end
end