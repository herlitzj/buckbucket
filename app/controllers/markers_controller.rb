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
  end

  # GET /markers/new
  def new
    @marker = Marker.new
  end

  # GET /markers/1/edit
  def edit
  end

  # POST /markers
  # POST /markers.json
  def create
    @marker = Marker.new(marker_params)

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
    begin
      @uri = URI('https://sandbox-api.venmo.com/v1/payments')
      # @uri = URI('https://api.venmo.com/v1/payments')
      @params = { :access_token => '7d0fcbbc4a0ca7f4d374996367ff32509cd6df437a22303945f53ad76f1f9411', 
                  :amount => 0.10, 
                  :phone => 15555555555, 
                  :note => "BuckBucket " + @marker.title,
                  :email => nil,
                  :uid => nil }
      @response = Net::HTTP.post_form(@uri, @params)
      @response_json = JSON.parse(@response.body)
      if @response_json["error"]
        flash[:warning] = "There was a problem processing your payment: " +
                        String(@response_json["error"]["message"]) +
                        String(@marker.attributes)
      else
        flash[:success] = "Payment Processed: " + 
                          String(@response_json["data"]["payment"]["target"]["user"]["display_name"]).split.map(&:capitalize).join(" ") + 
                          " successfully paid $" +
                          String(@response_json["data"]["payment"]["amount"])
      end
      redirect_to @marker
      # render text: @response_json
    rescue
      flash[:warning] = "There was a problem processing your payment"
      render text: @response_json
      # redirect_to @marker
    end

    # redirect_to markers_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_marker
      @marker = Marker.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def marker_params
      params.require(:marker).permit(:lat, :lon, :description, :title)
    end
end
