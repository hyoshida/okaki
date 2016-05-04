class UsersController < ApplicationController
  before_action :set_user, only: :show

  def index
    redirect_to root_path
  end

  def show
    redirect_to user_entries_path(@user)
  end

  private

  def set_user
    @user = User.find_by!(name: params[:name])
  end
end
