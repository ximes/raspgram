module Parser
	module HueLightsModule
		def init
			@matchers << HueLights.new
		end
	end
end