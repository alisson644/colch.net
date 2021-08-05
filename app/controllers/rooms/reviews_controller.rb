class Rooms::ReviewsController < ApplicationController
  before_action :require_authentication

  def create
    review = room.reviews.find_or_initialize_by(user_id: current_user.id)
    review.update!(params.require(:review).permit(:user_id, :room_id, :points))
    head :ok
  end

  def update
    create
  end

  private

  def room
    @room ||= Room.find(params[:room_id])
  end
end
