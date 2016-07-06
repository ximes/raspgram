class ScraperDefinitionsController < ApplicationController
  before_action :set_scraper, only: [:show, :edit, :update, :destroy]

  # GET /tricks
  # GET /tricks.json
  def index
    @scrapers = Scraper::Definition.all
  end

  # GET /tricks/1
  # GET /tricks/1.json
  def show
  end

  def new
  	@scraper = Scraper::Definition.new(active: true)
  end

  def create
  	@scraper = Scraper::Definition.new(scraper_params)

  	if @scraper.save
  		redirect_to scraper_definitions_path, notice: 'Scraper was successfully created.' 
  	else
  		render :edit
  	end
  end


  # GET /tricks/1/edit
  def edit
  end

  # PATCH/PUT /tricks/1
  # PATCH/PUT /tricks/1.json
  def update
    if @scraper.update(scraper_params)
      redirect_to scraper_definitions_path, notice: 'Scraper was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
	  if @scraper.destroy
	    redirect_to scraper_definitions_path, notice: 'Scraper was successfully deleted.'
	  else
	    redirect_to scraper_definitions_path, notice: 'An error occurred while deleting Scraper.'
	  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scraper
      @scraper = Scraper::Definition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scraper_params
      params.require(:scraper_definition).permit(:name, :active, :app_url, :list_url, :schedule_range => [], list_rules_attributes: [:id, :matcher_code, :action_code, :_destroy], detail_rules_attributes: [:id, :matcher_code, :action_code, :_destroy])
    end

end
