module Admin
  class EntriesController < Admin::ApplicationController
    before_action :set_entry, only: [:show, :edit, :update, :destroy]
    before_action :parse_keywords, only: :index

    def index
      @q = Entry.ransack(params[:q])
      @entries = @q.result.order(created_at: :desc).page(params[:page]).all

      respond_to do |format|
        format.html
        format.json { render json: @entries } # for select2
      end
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
        :category_id,
        :draft,
        :slug,
        :title,
        :headline,
        :body,
        :image,
        :remove_image
      )
    end

    # Based on https://github.com/activerecord-hackery/ransack/issues/218#issuecomment-16504630
    def parse_keywords
      return unless params[:q]
      keywords = params[:q].delete(:title_cont_all)
      return if keywords.blank?
      params[:q][:groupings] = keywords.split(' ').map { |keyword| { title_cont: keyword } }
    end
  end
end
