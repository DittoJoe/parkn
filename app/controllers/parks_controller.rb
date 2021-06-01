class ParksController < ApplicationController
   def index
    @parks = Park.all
  end
end
