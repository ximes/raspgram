class Message 

	include ActiveModel::Validations

	attr_accessor :content, :from, :to

	validates :content, presence: true
	validates :to, presence: true

	def initialize(args)
	   	args.each do |k,v|
	      instance_variable_set("@#{k}", v) unless v.nil?
	    end
	end

	def parse?
		
	end
	def parse!
		if parse?
			return Response.new
		end
	end
end