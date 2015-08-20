module Parser
	class Status < Matcher
		def parse(input, from)
			if /^system status/i.match input
				@input = input
				@from = from
			end
		end
		def callback
			Telegram.msg "Online", @from
		end
	end
end