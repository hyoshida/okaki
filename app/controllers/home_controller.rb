class HomeController < ApplicationController
  def index
    @entries = Entry.recent.page(params[:page]).per(per_page).all
  end
end
