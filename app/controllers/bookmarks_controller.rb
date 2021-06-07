class BookmarksController < ApplicationController
  def index
    @user = current_user
    @bookmarks = @user.bookmarks
  end

  def create
    @bookmark = Bookmark.new
    @park = Park.find(params[:park_id])
    @bookmark.park = @park
    @bookmark.user = current_user
    @bookmark.save
    redirect_to park_path(@park)
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to bookmarks_path
  end
end
