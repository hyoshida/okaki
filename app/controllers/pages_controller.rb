class PagesController < ApplicationController
  def show
    @page = Page.friendly.find(params[:id])
    raise ActiveRecord::RecordNotFound if !@page.active? && !current_user
  end
end
