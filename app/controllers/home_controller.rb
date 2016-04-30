class HomeController < ApplicationController
  def index
    @users = User.recent.all
    @entries = Entry.recent.all
  end
end
