class ProfileController < ApplicationController
  before_action :authenticate_user!

  def show
    @entries = current_user.entries.recent.page(params[:page]).per(20)
  end

  def edit
    redirect_to profile_path
  end

  def update
    redirect_to profile_path
  end

  def entries
    redirect_to profile_path
  end
end
