module Tricks
	Dir[File.join(File.dirname(__FILE__), '..', 'tricks') + "/*.rb"].each do |file| 
		include const_get(File.basename(file).gsub('.rb','').split("_").map{|ea| ea.capitalize}.join.to_s)
	end

	def parse_callback_queries
		Tricks.included_modules.each do |included_module|
			begin 
          		included_module::CallbackQuery.init(self)
			rescue
				nil
			end
        end
	end
	def parse_callback_messages
		Tricks.included_modules.each do |included_module|
			begin 
          		included_module::CallbackMessages.init(self)
			rescue
				nil
			end
        end
	end
	def parse_pre_filters
		Tricks.included_modules.each do |included_module|
          	begin 
          		included_module::PreFilter.init(self)
			rescue
				nil
			end
        end
	end
	def trick_commands
		Tricks.included_modules.map do |included_module|
			begin 
          		included_module::Definition.definition
      		rescue
      			nil
          	end
        end
	end
end
