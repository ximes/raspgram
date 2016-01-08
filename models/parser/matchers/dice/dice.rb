module Parser
	class Dice < Matcher
		def initialize
			@word = "dice"
			@option = 6
		end
		def help
			" [size](optional)"
		end
		def parse(input, from)
			options = input.match(/^([a-z]+)\s([0-9]+)$/i)
			if options and options[1] == @word and options[2].to_i
				@option = options[2].to_i
			end
			if /^#{@word}/i.match input
				@input = input
				@from = from
			end
		end
		def callback
			Telegram.msg "#{1+rand(@option)}", @from
		end
	end
end