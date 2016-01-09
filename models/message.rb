class Message 

	include ActiveModel::Validations

	attr_accessor :content, :from
	attr_reader :response

	include Parser

	validates :content, presence: true
	validates :from, presence: true

	def initialize(args)
	   	args.each do |k,v|
	      instance_variable_set("@#{k}", v) unless v.nil?
	    end
	    mark_as_read
	    parse!
	end

	def has_valid_response?
		@response.present? && @response.valid?
	end
	def has_errors?
		errors.any?
	end
	def respond
		if has_valid_response?
			@response.execute! 
		else
			raise "not valid response"
		end
	end

	private

	def parse!
		command = Parser::Input.parse(content, from)
		@response = Response.new command

		if has_valid_response?
			true
		else
			errors.add(:error, "Error")
			true
		end
	end

	def mark_as_read
		Telegram.mark_read(from)
	end
end