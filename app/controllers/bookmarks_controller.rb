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
    respond_to do |format|
      format.html
      format.json {render json: { partial: render_to_string(partial: "bookmarks/delete.html.erb") }}
    end
    # redirect_to park_path(@park)
  end

  def destroy

      @bookmark = Bookmark.find(params[:id]) if Bookmark.find(params[:id])
    if Bookmark.find(params[:id])
      @park = @bookmark.park
      @bookmark.destroy
      respond_to do |format|
        format.html
        format.json { render json: { partial: render_to_string(partial: "bookmarks/create.html.erb") } }
      end
    end
    # redirect_to park_path(@bookmark.park)
  end
end
