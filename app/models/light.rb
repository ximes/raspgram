class Light < Trick
	def self.setup_connection
		%x( echo 'hue all state')
	end
end
