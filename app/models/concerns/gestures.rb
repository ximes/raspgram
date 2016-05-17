module Gestures
	Dir[File.join(File.dirname(__FILE__), '..', 'gestures') + "/*.rb"].each do |file| 
		include const_get(File.basename(file).gsub('.rb','').capitalize.to_s)
	end

	def parse_callback_queries
		Gestures.included_modules.each do |included_module|
          included_module::CallbackQuery.init(self)
        end
	end
	def gesture_commands
		Gestures.included_modules.map do |included_module|
          included_module::Definition.definition
        end
	end
end
