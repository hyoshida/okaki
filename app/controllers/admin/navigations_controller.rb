module Admin
  class NavigationsController < Admin::ApplicationController
    before_action :set_navigation, only: [:show, :edit, :update, :destroy]

    def index
      @navigations = Navigation.by_newest
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
