class ParksController < ApplicationController
  def index
    @parks = Park.all
  end

  def show
    @categories = Category.all
    @park = Park.find(params[:id])
    @park_arr = []
    @park_arr << @park
    @markers = @park_arr.map do |park|
      {
        lat: park.latitude.nil? ? 59.3354662 : park.latitude,
        lng: park.longitude.nil? ? 18.0600026 : park.longitude
      }
    end
  end

  def new
    @park = Park.new
  end

  def create
    @park = Park.new(park_params)
    if @park.save
      redirect_to park_path(@park)
    else
      render :new
    end
  end

  private

  def park_params
    params.require(:park).permit(:name, :address, :region, :details, :photos)   
  end
end
