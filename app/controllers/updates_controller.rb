class UpdatesController < ActionController::Base
  def create
  	logger.debug(params.inspect)
  	render nothing: true
  end
end
