class ParksController < ApplicationController
  def index
    @parks = Park.all
    if params[:query].present?
      #sql_query = "name ILIKE :query OR details ILIKE :query"
      @parks = Park.search_by_name_and_details(params[:query])
    else
      @parks = Park.all
    end
    @markers = @parks.geocoded.map do |park|
      {
        lat: park.latitude,
        lng: park.longitude,
        info_window: render_to_string(partial: "info_window", locals: { park: park })
      }
    end
  end

  def show
    @review = Review.new
    @park = Park.find(params[:id])
    @park_categories = ParkCategory.where(park_id: @park.id)
    @park_arr = []
    @park_arr << @park
    @markers = @park_arr.map do |park|
      {
        lat: park.latitude.nil? ? 59.3354662 : park.latitude,
        lng: park.longitude.nil? ? 18.0600026 : park.longitude,
        info_window: render_to_string(partial: "info_window", locals: { park: park })
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
    Category.all.each do |category|
      ParkCategory.create(category_id: category.id, park_id: @park.id)
    end
  end

  def edit
    @park = Park.find(params[:id])
  end

  def update
    @park = Park.find(params[:id])
    @park.update(park_params)
    redirect_to park_path(@park)
  end

  private

  def park_params
    params.require(:park).permit(:name, :address, :region, :details, photos: [])
  end
end
