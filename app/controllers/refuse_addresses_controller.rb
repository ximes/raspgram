class RefuseAddressesController < ApplicationController
  before_action :set_refuse_address, only: [:show, :edit, :update, :destroy]

  # GET /tricks
  # GET /tricks.json
  def index
    @refuse_addresses = RefuseAddress.all
  end

  # GET /tricks/1
  # GET /tricks/1.json
  def show
  end

  def new
  	@refuse_address = RefuseAddress.new(active: true)
  end

  def create
  	@refuse_address = RefuseAddress.new(refuse_address_params)

	if @refuse_address.save
		redirect_to refuse_addresses_path, notice: 'Address was successfully created.' 
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
    if @refuse_address.update(refuse_address_params)
      redirect_to refuse_addresses_path, notice: 'Address was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
	  if @refuse_address.destroy
	    redirect_to refuse_addresses_path, notice: 'Address was successfully deleted.'
	  else
	    redirect_to refuse_addresses_path, notice: 'An error occurred while deleting Address.'
	  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_refuse_address
      @refuse_address = RefuseAddress.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def refuse_address_params
      params.require(:refuse_address).permit(:name, :house_no, :postcode, :active)
    end

end
