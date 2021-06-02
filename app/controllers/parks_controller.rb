class ParksController < ApplicationController
   def index
    @parks = Park.all
    if params[:query].present?
      #sql_query = "name ILIKE :query OR details ILIKE :query"
      @parks = Park.search_by_name_and_details(params[:query])
    else
      @parks = Park.all
    end
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
end
