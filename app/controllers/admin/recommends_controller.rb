module Admin
  class RecommendsController < Admin::ApplicationController
    before_action :set_recommend, only: [:show, :edit, :update, :destroy, :move_lower, :move_higher, :move_to_bottom, :move_to_top]

    def index
      @recommends = Recommend.all
    end

    def show
      render :edit
    end

    def new
      @recommend = Recommend.new(category_id: params[:category_id])
    end

    def edit
    end

    def create
      @recommend = Recommend.new(recommend_params)

      if @recommend.save
        redirect_to [:admin, @recommend], notice: 'Recommend was successfully created.'
      else
        render :new
      end
    end

    def update
      if @recommend.update(recommend_params)
        redirect_to [:admin, @recommend], notice: 'Recommend was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @recommend.destroy
      redirect_to admin_recommends_url, notice: 'Recommend was successfully destroyed.'
    end

    def move_lower
      @recommend.move_lower
      redirect_to admin_recommends_url, notice: 'Recommend was successfully moved.'
    end

    def move_higher
      @recommend.move_higher
      redirect_to admin_recommends_url, notice: 'Recommend was successfully moved.'
    end

    def move_to_bottom
      @recommend.move_to_bottom
      redirect_to admin_recommends_url, notice: 'Recommend was successfully moved.'
    end

    def move_to_top
      @recommend.move_to_top
      redirect_to admin_recommends_url, notice: 'Recommend was successfully moved.'
    end

    private

    def set_recommend
      @recommend = Recommend.find(params[:id])
    end

    def recommend_params
      params.fetch(:recommend, {}).permit(
        :category_id,
        :entry_id
      )
    end
  end
end
