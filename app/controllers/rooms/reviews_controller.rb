class Rooms::ReviewsController < ApplicationController
  before_action :require_authentication

  def create
    review = room.review.find_or_initialize_by_user_id(current_user.id)
    review.update!(params[:review])

    head :ok
  end

  def update
    create
  end

  private

  def room
    @room ||= Room.find(params[:roo_id])
  end
end