class ReservationsController < ApplicationController
  before_action :authenticate_user!
  def new
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new
  end

  def confirm
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new(reservation_params)
    if @reservation.invalid?
      render :new
    end
  end

  def create
    @room = Room.find(params[:room_id])
    @reservation = current_user.reservations.build(reservation_params)
    @reservation.room_id = @room.id
    if @reservation.save
      redirect_to reservations_path, notice: "予約が完了しました"
    else
      render :new
    end
  end

  def index
    @reservations = current_user.reservations
  end

  private

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :guests, :room_id)
  end
end
