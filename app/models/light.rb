class Light < Trick
	include ActiveModel::Validations
	include ActiveModel::Conversion
	extend ActiveModel::Naming

	@@client = Light.new

 	private_class_method :new

 	def initialize
 		Light.setup_connection
 	end
	def self.client
		return @@client
	end

	def self.setup_connection
		%x( echo 'hue all state')
	end
	
	def self.check_connection
	    begin 
	      Hue::Client.new
	    rescue
	      false
	    end
	end

	def self.hex_to_hue(value)

  		parts = (value.match /^(\#?)(..?)(..?)(..?)/ )[2..4]
  		parts.map!{ |x| x + x } if value.size == 4
      	
      	parts = parts.map(&:hex)

		Color::RGB.by_hex(value).to_hsl.hue * 182.04
	end

	def self.hue_to_hex(hue, saturation, brightness)
		#Color::HSL.new((hue.to_i / 182.04), saturation.to_i / 2.55, brightness.to_i / 2.55).to_rgb.to_a.map{|s| (s * 100).to_i.to_s(16)}.join
		Color::HSL.new(rand(360), rand(100), rand(100)).to_rgb.to_a.map{|s| (s * 100).to_i.to_s(16).rjust(2, "0")}.join
		#value / 182.04 if value
	end

	def self.attr_accessor(*vars)
	@attributes ||= []
	@attributes.concat( vars )
	super
	end

	def self.attributes
	@attributes
	end

	def initialize(attributes={})
	attributes && attributes.each do |name, value|
	 send("#{name}=", value) if respond_to? name.to_sym 
	end
	end

	def persisted?
	false
	end

	def self.inspect
	"#<#{ self.to_s} #{ self.attributes.collect{ |e| ":#{ e }" }.join(', ') }>"
	end
end
