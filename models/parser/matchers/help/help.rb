module Parser
	class Help < Matcher
		def initialize
			@word = "help"
		end
		def callback
			Parser::Input.rule_list(@input, @from).each do |r|
				Response.new(Telegram.msg r, @from).execute!
			end
		end
	end
end