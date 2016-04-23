class TricksController < ApplicationController
  before_action :set_trick, only: [:show, :edit, :update]

  # GET /tricks
  # GET /tricks.json
  def index
    @tricks = Trick.all
  end

  # GET /tricks/1
  # GET /tricks/1.json
  def show
  end

  # GET /tricks/1/edit
  def edit
  end

  # PATCH/PUT /tricks/1
  # PATCH/PUT /tricks/1.json
  def update
    respond_to do |format|
      if @trick.update(trick_params)
        format.html { redirect_to @trick, notice: 'Trick was successfully updated.' }
        format.json { render :show, status: :ok, location: @trick }
      else
        format.html { render :edit }
        format.json { render json: @trick.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trick
      @trick = Trick.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trick_params
      params.require(:trick).permit(:core, :active)
    end
end
