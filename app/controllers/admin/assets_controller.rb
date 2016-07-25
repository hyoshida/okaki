module Admin
  class AssetsController < Admin::ApplicationController
    before_action :set_asset, only: [:show, :edit, :update, :destroy]

    def index
      @q = Asset.ransack(params[:q])
      @assets = @q.result.order(created_at: :desc).page(params[:page]).all
    end

    def show
      render :edit
    end

    def new
      @asset = Asset.new
    end

    def edit
    end

    def create
      @asset = Asset.new(asset_params)
      @asset.user = current_user

      if @asset.save
        redirect_to [:admin, @asset], notice: 'Asset was successfully created.'
      else
        render :new
      end
    end

    def update
      if @asset.update(asset_params)
        redirect_to [:admin, @asset], notice: 'Asset was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @asset.destroy
      redirect_to admin_assets_url, notice: 'Asset was successfully destroyed.'
    end

    private

    def set_asset
      @asset = Asset.find(params[:id])
    end

    def asset_params
      params.fetch(:asset, {}).permit(
        :title,
        :file
      )
    end
  end
end
