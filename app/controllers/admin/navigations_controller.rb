module Admin
  class NavigationsController < Admin::ApplicationController
    before_action :set_navigation, only: [:show, :edit, :update, :destroy, :move_lower, :move_higher, :move_to_bottom, :move_to_top]

    def index
      @navigations = Navigation.all
    end

    def show
      render :edit
    end

    def new
      @navigation = Navigation.new(location: params[:location])
    end

    def edit
    end

    def create
      @navigation = Navigation.new(navigation_params)

      if @navigation.save
        redirect_to [:admin, @navigation], notice: 'Navigation was successfully created.'
      else
        render :new
      end
    end

    def update
      if @navigation.update(navigation_params)
        redirect_to [:admin, @navigation], notice: 'Navigation was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @navigation.destroy
      redirect_to admin_navigations_url, notice: 'Navigation was successfully destroyed.'
    end

    def move_lower
      @navigation.move_lower
      redirect_to admin_navigations_url, notice: 'Navigation was successfully moved.'
    end

    def move_higher
      @navigation.move_higher
      redirect_to admin_navigations_url, notice: 'Navigation was successfully moved.'
    end

    def move_to_bottom
      @navigation.move_to_bottom
      redirect_to admin_navigations_url, notice: 'Navigation was successfully moved.'
    end

    def move_to_top
      @navigation.move_to_top
      redirect_to admin_navigations_url, notice: 'Navigation was successfully moved.'
    end

    private

    def set_navigation
      @navigation = Navigation.find(params[:id])
    end

    def navigation_params
      params.fetch(:navigation, {}).permit(
        :active,
        :name,
        :url,
        :location
      )
    end
  end
end
