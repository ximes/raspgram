module Parser
	class Dice < Matcher
		def parse(input, from)
			if /^dice/i.match input
				@input = input
				@from = from
			end
		end
		def callback
			Telegram.msg "#{1+rand(6)}", @from
		end
	end
end