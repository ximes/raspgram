class UpdatesController < ActionController::Base
  def create
  	logger.debug(params.inspect)
	bot = TelegramBot.new
	bot.update(bot_params)
	
  	render nothing: true
  end

  def bot_params
  	params
  end
end
