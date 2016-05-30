class WhitelistsController < ApplicationController
  before_action :set_whitelist, only: [:show, :edit, :update, :destroy]

  # GET /whitelists
  # GET /whitelists.json
  def index
    @whitelists = Whitelist.all
  end

  # GET /whitelists/1
  # GET /whitelists/1.json
  def show
  end

  # GET /whitelists/new
  def new
    @whitelist = Whitelist.new
  end

  # GET /whitelists/1/edit
  def edit
  end

  # POST /whitelists
  # POST /whitelists.json
  def create
    @whitelist = Whitelist.new(whitelist_params)

    respond_to do |format|
      if @whitelist.save
        format.html { redirect_to @whitelist, notice: 'Whitelist was successfully created.' }
        format.json { render :show, status: :created, location: @whitelist }
      else
        format.html { render :new }
        format.json { render json: @whitelist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /whitelists/1
  # PATCH/PUT /whitelists/1.json
  def update
    respond_to do |format|
      if @whitelist.update(whitelist_params)
        format.html { redirect_to @whitelist, notice: 'Whitelist was successfully updated.' }
        format.json { render :show, status: :ok, location: @whitelist }
      else
        format.html { render :edit }
        format.json { render json: @whitelist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /whitelists/1
  # DELETE /whitelists/1.json
  def destroy
    @whitelist.destroy
    respond_to do |format|
      format.html { redirect_to whitelists_url, notice: 'Whitelist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_whitelist
      @whitelist = Whitelist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def whitelist_params
      params.require(:whitelist).permit(:name, :user_id, :active, :phone_no)
    end
end
