class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = current_user
  end

  def edit_profile
    @user = current_user
  end

  def update_profile
    @user = current_user
    if @user.update(profile_params)
      redirect_to user_show_path, notice: "プロフィールを更新しました"
    else
      render :edit_profile
    end
  end

  private

  def profile_params
    params.require(:user).permit(:name, :bio, :icon)
  end
end
