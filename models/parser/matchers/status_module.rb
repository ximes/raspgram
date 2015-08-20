module Parser
	module StatusModule
		def init
			@matchers << Status.new
		end
	end
end