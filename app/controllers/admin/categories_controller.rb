module Admin
  class CategoriesController < Admin::ApplicationController
    def index
      @categories = Category.all
    end

    def create
      Category.from_jstree!(params[:jstree_json])
      redirect_to admin_categories_path
    end
  end
end
