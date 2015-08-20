require_relative "parser/matchers/matcher"
require_relative "parser/matchers/status_module"

module Parser
	class Input

		attr_accessor :matchers

	 	include DiceModule
		include StatusModule

		def self.parse(input, from)
			parser = self.new(input, from)
			
			#parse all input classes looking for a match
			rules = parser.matchers.select do |match|
				match if match.parse(input, from)
			end

			#returns a confirmation, a telegram api command, or nill
			# Telegram:msg, Telegram:photo, etc..
			rules.each do |rule|
				return rule.callback
			end
		   	nil
		end
		private
		def initialize(input, from)
			@matchers = []
			self.class.included_modules.map do |mod|
				mod.instance_method( :init ).bind( self ).call if mod.parent.name == "Parser"
			end
		end
	end
end