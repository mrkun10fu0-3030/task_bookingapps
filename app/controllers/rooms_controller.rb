class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = current_user.rooms
  end

  def show
    @room = Room.find(params[:id])
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to rooms_path, notice: "施設を登録しました"
    else
      render :new
    end
  end

  def search
    @rooms = Room.all
    if params[:area].present?
      @rooms = @rooms.where("address LIKE ?", "%#{params[:area]}%")
    end
    if params[:keyword].present?
      @rooms = @rooms.where("name LIKE ? OR description LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
    end
    @total = @rooms.count
  end

  private

  def room_params
    params.require(:room).permit(:name, :description, :price, :address, :image)
  end
end
