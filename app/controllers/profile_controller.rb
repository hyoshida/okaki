class ProfileController < ApplicationController
  before_action :authenticate_user!

  def show
    redirect_to activities_profile_path
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
    @entries = current_user.entries.recent.page(params[:page]).per(20)
  end

  def activities
    @activities = PublicActivity::Activity.order(created_at: :desc).limit(20)
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
