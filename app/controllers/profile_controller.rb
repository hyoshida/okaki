class ProfileController < ApplicationController
  before_action :authenticate_user!

  def show
    @entries = current_user.entries.recent.page(params[:page]).per(20)
  end

  def edit
  end

  def update
    if current_user.update(profile_params)
      redirect_to profile_path, notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  def entries
    redirect_to profile_path
  end

  private

  def profile_params
    params[:user].delete(:password) if params[:user][:password].blank?
    params.fetch(:user, {}).permit(
      :nickname,
      :profile,
      :email,
      :password
    )
  end
end
