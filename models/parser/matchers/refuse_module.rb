module Parser
	module RefuseModule
		def init
			@matchers << Refuse.new
		end
	end
end