module Parser
	class Matcher
		attr :input, :from
		attr_accessor :word, :help
		def parse(input, from)
			raise "You must redefine this method!"
		end
		def callback
			raise "You must redefine this method!"
		end
	end
end