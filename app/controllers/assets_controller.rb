class AssetsController < ApplicationController
  before_action :authenticate_user!

  def create
    @asset = current_user.assets.new(asset_param)

    return render json: [error: 'custom_failure'], status: 304 unless @asset.save

    respond_to do |format|
      json = [@asset.to_jquery_upload].to_json
      format.html { render json: json, content_type: 'text/html', layout: false }
      format.json { render json: json }
    end
  end

  private

  def asset_param
    params.fetch(:asset, {}).permit(
      :title,
      :file
    )
  end
end
