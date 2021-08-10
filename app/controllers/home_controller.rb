class HomeController < ApplicationController
  def index
    @rooms = Room.most_recent.limit(3)
  end
end