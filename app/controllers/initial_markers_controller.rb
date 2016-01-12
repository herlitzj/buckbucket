class InitialMarkersController < ApplicationController
  before_action :set_marker, only: [:show, :edit, :update, :destroy]

  # GET /markers/new
  def new
    @initial_marker = InitialMarker.new
  end

  # POST /markers
  # POST /markers.json
  def create
    @initial_marker = InitialMarker.new(marker_params)

    respond_to do |format|
        format.html { redirect_to new_marker_url(:lat => @initial_marker.lat,
                                                 :lon => @initial_marker.lon), notice: 'Marker was successfully created.' }
        format.json { render :show, status: :created, location: @initial_marker }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marker
      @initial_marker = InitialMarker.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def marker_params
      params.require(:initial_marker).permit(:lat, :lon)
    end
end
