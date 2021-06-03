class VotesController < ApplicationController
  def create
    @vote = Vote.new
    @park_category = ParkCategory.find(params[:park_category_id])
    @vote.park_category = @park_category
    @vote.user = current_user
    @vote.save
    redirect_to "/parks/#{@park_category.park.id}"
  end
end
