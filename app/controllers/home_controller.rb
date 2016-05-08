class HomeController < ApplicationController
  def index
    @entries = Entry.recent.all
  end
end
