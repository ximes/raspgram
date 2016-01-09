module Parser
	class Matcher
		attr :input, :from
		attr_accessor :word, :help, :man, :response

		def parse(input, from)
			if /^#{@word}/i.match input
				@input = input
				@from = from
				return true
			end
			if /^man\s#{@word}/i.match input
				@show_man = true
				@from = from
				return true
			end
		end

		def man
			help
		end

		def callback
			if @show_man
				Telegram.msg man, @from
			elsif @response.present?
				Telegram.msg @response, @from
			end
		end
	end
end