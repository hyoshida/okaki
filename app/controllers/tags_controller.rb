class TagsController < ApplicationController
  def show
    @tag_name = params[:id]
    @entries = Entry.tagged_with(@tag_name).recent.page(params[:page]).per(per_page).all
  end
end
