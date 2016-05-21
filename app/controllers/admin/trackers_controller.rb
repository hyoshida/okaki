module Admin
  class TrackersController < Admin::ApplicationController
    before_action :set_tracker, only: [:show, :edit, :update, :destroy]

    def index
      @trackers = Tracker.by_newest
    end

    def show
      render :edit
    end

    def new
      @tracker = Tracker.new
    end

    def edit
    end

    def create
      @tracker = Tracker.new(tracker_params)

      if @tracker.save
        redirect_to [:admin, @tracker], notice: 'Tracker was successfully created.'
      else
        render :new
      end
    end

    def update
      if @tracker.update(tracker_params)
        redirect_to [:admin, @tracker], notice: 'Tracker was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @tracker.destroy
      redirect_to admin_trackers_url, notice: 'Tracker was successfully destroyed.'
    end

    private

    def set_tracker
      @tracker = Tracker.find(params[:id])
    end

    def tracker_params
      params.fetch(:tracker, {}).permit(
        :active,
        :name,
        :tracker_id,
        :code
      )
    end
  end
end
