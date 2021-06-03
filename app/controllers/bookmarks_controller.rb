class BookmarksController < ApplicationController
  def create
    @bookmark = Bookmark.new
    @park = Park.find(params[:park_id])
    @bookmark.park = @park
    @bookmark.user = current_user
    @bookmark.save
  end
end
