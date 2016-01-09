module Parser
	class Status < Matcher
		def initialize
			@word = "system status"
		end
		def callback
			@response = "Online"
			super
		end
	end
end