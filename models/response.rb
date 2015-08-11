class Response

	attr_reader :command
	
	def initialize(cmd = nil)
		@command = cmd
	end

	def execute!
		if valid?
			system("screen -r tgram -p 0 -X stuff \"#{@command} $(printf \\\r)\"")
		else
			true
		end
	end

	def valid?
		!@command.blank?
	end
end