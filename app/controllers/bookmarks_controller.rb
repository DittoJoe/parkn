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

      @bookmark.save!
      if @bookmark.save!
        p '------------------------------------------------------------------------------------'
        p @bookmark
        respond_to do |format|
          format.html
          format.json {render json: { partial: render_to_string(partial: "bookmarks/delete.html.erb") }}
        end
      end
    # redirect_to park_path(@park)
  end

  def destroy
    if Bookmark.find(params[:id])
      @bookmark = Bookmark.find(params[:id])
      p @bookmark
    end
    if Bookmark.find(params[:id])
      @park = @bookmark.park
        @bookmark.destroy
        respond_to do |format|
          format.html
          format.json { render json: { partial: render_to_string(partial: "bookmarks/create.html.erb") } }
        end
      end
  end

  def destroy_fresh
     @bookmark = Bookmark.find(params[:id]) if Bookmark.find(params[:id])
    if Bookmark.find(params[:id])
      @park = @bookmark.park
      @bookmark.destroy
      redirect_to bookmarks_path
    end
  end
end
