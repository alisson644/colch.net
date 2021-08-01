class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show edit update destroy ]

  before_action :require_authentication, 
      :only => [:new, :edit, :create, :update, :destroy]


  def index
    @rooms = Room.all.most_recent
  end

  def show
  end

  def new
    @room = current_user.rooms.build
  end

  def edit
    @room = current_user.rooms.find(params[:id])
  end

  def create
    @room = current_user.rooms.build(room_params)

    if @room.save
      redirect_to @room, :notice => t('flash.notice.room_created')
    else
      render action: "new"
    end
  end

  def update
    @room = current_user.rooms.find(params[:id])

    respond_to do |format|
       if @room.update(room_params)
          format.html { redirect_to @room,
            notice: 'Room was successfully updated.' }
          format.json { head :no_content }
       else
          format.html { render action: "edit" }
          format.json { render json: @room.errors,
            status: :unprocessable_entity }
       end
    end
  end

  def destroy
    @room.destroy
    redirect_to rooms_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:title, :location, :description,)
    end
end
