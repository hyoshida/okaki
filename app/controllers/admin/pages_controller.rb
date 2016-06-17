module Admin
  class PagesController < Admin::ApplicationController
    before_action :set_page, only: [:show, :edit, :update, :destroy]

    def index
      @pages = Page.by_newest
    end

    def show
      render :edit
    end

    def new
      @page = Page.new
    end

    def edit
    end

    def create
      @page = Page.new(page_params)
      @page.slug = @page.normalize_slug(page_params[:slug])

      if @page.save
        redirect_to [:admin, @page], notice: 'Page was successfully created.'
      else
        render :new
      end
    end

    def update
      @page.attributes = page_params
      @page.slug = @page.normalize_slug(page_params[:slug])

      if @page.save
        redirect_to [:admin, @page], notice: 'Page was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @page.destroy
      redirect_to admin_pages_url, notice: 'Page was successfully destroyed.'
    end

    private

    def set_page
      @page = Page.find(params[:id])
    end

    def page_params
      params.fetch(:page, {}).permit(
        :active,
        :slug,
        :title,
        :content
      )
    end
  end
end
