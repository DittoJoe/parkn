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
  end
end
