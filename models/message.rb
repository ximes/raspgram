class Message 

	include ActiveModel::Validations

	attr_accessor :content, :from, :to
	attr_reader :response

	validates :content, presence: true
	validates :to, presence: true

	def initialize(args)
	   	args.each do |k,v|
	      instance_variable_set("@#{k}", v) unless v.nil?
	    end
	    parse!
	end

	def has_valid_response?
		response.present? && response.valid?
	end
	def has_errors?
		errors.any?
	end
	def respond
		response.execute! if has_valid_response?
	end

	private

	def parse!
		command = "command"
		response = Response.new command

		if has_valid_response?
			true
		else
			errors.add(:error, "Error")
			true
		end
	end
end