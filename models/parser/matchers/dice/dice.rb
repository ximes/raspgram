module Parser
	class Dice < Matcher
		def initialize
			@word = "dice"
			@option = 6
		end
		def help
			" [size](optional)"
		end
		def man
			"Examples: \ndice \n dice 3 \n dice 90"
		end
		def parse(input, from)
			options = input.match(/^([a-z]+)\s([0-9]+)$/i)
			if options and options[1] == @word and options[2].to_i
				@option = options[2].to_i
				return true
			end
			super
		end
		def callback
			@response = "#{1+rand(@option)}"
			super
		end
	end
end