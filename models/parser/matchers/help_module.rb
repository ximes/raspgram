module Parser
	module HelpModule
		def init
			@matchers << Help.new
		end
	end
end