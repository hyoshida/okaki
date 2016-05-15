class CategoriesController < ApplicationController
  before_action :set_category

  def show
    @entries = Entry.where(category_id: @category.subtree_ids).recent.page(params[:page]).per(per_page).all
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end
end
