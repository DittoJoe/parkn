class BookmarksController < ApplicationController
  def index
    @user = current_user
    @bookmarks = @user.bookmarks
  end
end
