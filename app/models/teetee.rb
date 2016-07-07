class Teetee < Trick

	def self.current_design
      	begin 
            destination_path = Rails.root.join('tmp') 
            Scraper::Definition.init
            Capybara.app_host = "http://www.teetee.eu/"
            Capybara.visit('http://www.teetee.eu/')

            design_url = Capybara.find('.box-design.sidebar img')['src']
            
            filename = "#{Date.today.to_s}.png"

            if design_url
                system("wget -P #{destination_path} #{design_url} -O #{destination_path}/#{filename}") unless File.exists?(File.join(destination_path, filename))
                response = {text: 'Today\'s design: http://www.teetee.eu', file: File.join(destination_path, filename)}
            end
            
   		rescue Exception => e
   			Rails.logger.debug e
   			response = {text: e}
    	end
	end
end