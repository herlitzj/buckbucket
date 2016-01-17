class MarkersController < ApplicationController
  before_action :set_marker, only: [:show, :edit, :update, :destroy]

  # GET /markers
  # GET /markers.json
  def index
    @markers = Marker.all
  end

  # GET /markers/1
  # GET /markers/1.json
  def show
    @marker = Marker.find(params[:id])
    gon.single_marker_json = JSON.parse(@marker.to_json)

    @claims = ClaimedMarker.where(marker_id: @marker.id)
  end

  # GET /markers/new
  def new
    @marker = Marker.new
  end

  # GET /markers/1/edit
  def edit
    if current_user.nil?
      redirect_to root_path 
    elsif current_user.id != @marker.user_id
      redirect_to root_path
    end
  end

  # POST /markers
  # POST /markers.json
  def create
    if current_user.nil?
      @marker = Marker.new(marker_params)
      @marker.user_id = 0
    else
      @marker = current_user.markers.build(marker_params)
    end

    respond_to do |format|
      if @marker.save
        format.html { redirect_to root_path, notice: 'Marker was successfully created.' }
        format.json { render :show, status: :created, location: @marker }
      else
        format.html { render :new }
        format.json { render json: @marker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /markers/1
  # PATCH/PUT /markers/1.json
  def update
    respond_to do |format|
      if @marker.update(marker_params)
        format.html { redirect_to root_path, notice: 'Marker saved.' }
        format.json { render :show, status: :ok, location: @marker }
      else
        format.html { render :edit }
        format.json { render json: @marker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /markers/1
  # DELETE /markers/1.json
  def destroy
    @marker.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Marker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def make_payment
    @marker = Marker.find(params[:id])
    @claim = ClaimedMarker.find(params[:claim_id])
    @owner = User.find(@claim.owner_id)
    @claimer = User.find(@claim.claimer_id)
    note = @marker.title
    price = @marker.price

    begin
      @response_json = VenmoApi.return_venmo_json(@owner.venmo_token, @claimer.phone, note, price)
      if @response_json["error"]
        flash[:warning] = "There was a problem processing your payment: " +
                        String(@response_json["error"]["message"]) +
                        String(@marker.attributes)
      else
        flash[:success] = "Payment Processed: " + 
                          String(@response_json["data"]["payment"]["target"]["user"]["display_name"]).split.map(&:capitalize).join(" ") + 
                          " successfully paid $" +
                          String(@response_json["data"]["payment"]["amount"])
        ClaimedMarker.set_to_paid(@claim.id)
      end
      redirect_to @marker
      # render text: @response_json
    rescue
      flash[:warning] = "There was a problem processing your payment"
      render text: @response_json
      # redirect_to @marker
    end

  end

  def claim_marker
    @marker = Marker.find(params[:id])
    @claimed_marker = ClaimedMarker.new(marker_id: @marker.id, owner_id: @marker.user_id, 
                                      claimer_id: current_user.id)
    respond_to do |format|
      if @claimed_marker.save
        format.html { redirect_to @marker, notice: 'Marker was successfully claimed.' }
        format.json { render :show, status: :created, location: @marker }
      else
        format.html { redirect_to show_marker_path(@marker), notice: 'There was an error claiming your marker.' }
        format.json { render json: @marker.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marker
      @marker = Marker.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def marker_params
      params.require(:marker).permit(:lat, :lon, :description, :title, :price)
    end
end
