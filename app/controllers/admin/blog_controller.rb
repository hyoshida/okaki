module Admin
  class BlogController < Admin::ApplicationController
    before_action :set_blog, only: [:show, :edit, :update]

    def show
      render :edit
    end

    def edit
    end

    def update
      if @blog.update(blog_params)
        redirect_to admin_blog_path, notice: 'Blog was successfully updated.'
      else
        render :edit
      end
    end

    private

    def set_blog
      @blog = Blog.instance
    end

    def blog_params
      params.fetch(:blog, {}).permit(
        :title,
        :meta_keywords,
        :meta_description,
        :facebook_page_url,
        :twitter_uid
      )
    end
  end
end
