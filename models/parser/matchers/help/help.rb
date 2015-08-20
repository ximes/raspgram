module Parser
	class Help < Matcher
		def initialize
			@word = "help"
		end
		def parse(input, from)
			
			if /^#{@word}/i.match input
				@input = input
				@from = from
			end
		end
		def callback
			Parser::Input.rule_list(@input, @from).each do |r|
				Response.new(Telegram.msg r, @from).execute!
			end
		end
	end
end