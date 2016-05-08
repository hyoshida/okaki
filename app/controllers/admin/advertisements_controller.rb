module Admin
  class AdvertisementsController < Admin::ApplicationController
    before_action :set_advertisement, only: [:show, :edit, :update, :destroy]

    def index
      @q = Advertisement.ransack(params[:q])
      @advertisements = @q.result.order(updated_at: :desc).page(params[:page]).all
    end

    def show
      render :edit
    end

    def new
      @advertisement = Advertisement.new
    end

    def edit
    end

    def create
      @advertisement = Advertisement.new(advertisement_params)

      if @advertisement.save
        redirect_to [:admin, @advertisement], notice: 'Advertisement was successfully created.'
      else
        render :new
      end
    end

    def update
      if @advertisement.update(advertisement_params)
        redirect_to [:admin, @advertisement], notice: 'Advertisement was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @advertisement.destroy
      redirect_to admin_advertisements_url, notice: 'Advertisement was successfully destroyed.'
    end

    private

    def set_advertisement
      @advertisement = Advertisement.find(params[:id])
    end

    def advertisement_params
      params.fetch(:advertisement, {}).permit(
        :active,
        :title,
        :url,
        :image
      )
    end
  end
end
