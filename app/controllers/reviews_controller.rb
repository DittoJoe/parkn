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
      @rating = calculate_average(@park)
      redirect_to park_path(@park)
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end

  def calculate_average(park)
    reviews = park.reviews
    total = 0
    reviews.each do |review|
      total += review.rating
    end
    return total / reviews.count.to_f.round(1)
  end
end
