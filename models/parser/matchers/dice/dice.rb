module Parser
	class Dice < Matcher
		def initialize
			@word = "dice"
		end
		def help
			" [size](optional)"
		end
		def parse(input, from)
			if /^#{@word}/i.match input
				@input = input
				@from = from
			end
		end
		def callback
			Telegram.msg "#{1+rand(6)}", @from
		end
	end
end