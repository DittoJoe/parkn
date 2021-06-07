class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @park = Park.find(params[:park_id])
    @review.park = @park
  end

  def create
    @review = Review.new(review_params)
    @park = Park.find(params[:park_id])
    @review.park = @park
    @review.user = current_user
    if @review.save
      redirect_to park_path(@park)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end
end
