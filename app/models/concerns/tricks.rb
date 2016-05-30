module Tricks
	Dir[File.join(File.dirname(__FILE__), '..', 'tricks') + "/*.rb"].each do |file| 
		include const_get(File.basename(file).gsub('.rb','').split("_").map{|ea| ea.capitalize}.join.to_s)
	end

	def parse_callback_queries
		Tricks.included_modules.each do |included_module|
          included_module::CallbackQuery.init(self)
        end
	end
	def trick_commands
		Tricks.included_modules.map do |included_module|
          included_module::Definition.definition
        end
	end
end
