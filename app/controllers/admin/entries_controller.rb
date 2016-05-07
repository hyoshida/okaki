module Admin
  class EntriesController < Admin::ApplicationController
    before_action :set_entry, only: [:show, :edit, :update, :destroy]

    def index
      @q = Entry.ransack(params[:q])
      @entries = @q.result.order(created_at: :desc).page(params[:page]).all
    end

    def show
      render :edit
    end

    def new
      @entry = Entry.new
    end

    def edit
    end

    def create
      @entry = Entry.new(entry_params)

      if @entry.save
        redirect_to [:admin, @entry], notice: 'Entry was successfully created.'
      else
        render :new
      end
    end

    def update
      if @entry.update(entry_params)
        redirect_to [:admin, @entry], notice: 'Entry was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @entry.destroy
      redirect_to admin_entries_url, notice: 'Entry was successfully destroyed.'
    end

    private

    def set_entry
      @entry = Entry.find(params[:id])
    end

    def entry_params
      params.fetch(:entry, {}).permit(
        :draft,
        :slug,
        :title,
        :headline,
        :body
      )
    end
  end
end
