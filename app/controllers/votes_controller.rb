class VotesController < ApplicationController
  def index
    @votes = Votes.all
  end

  def create
    @vote = Vote.new
    @park_category = ParkCategory.find(params[:park_category_id])
    @vote.park_category = @park_category
    @vote.user = current_user
    @vote.save
    respond_to do |format|
      format.html
      format.json { render json: { counter: @park_category.votes.count } }
    end
  end
end
