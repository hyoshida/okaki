class HomeController < ApplicationController
  def index
    @entries = Entry.published.recent.page(params[:page]).per(per_page).all
  end

  # Based on http://stackoverflow.com/questions/4827232/generating-rss-feed-in-rails-3/4832591#4832591
  def feed
    # this will be the name of the feed displayed on the feed reader
    @title = Blog.instance.title

    # the news items
    @entries = Entry.published.recent.limit(20)

    # this will be our Feed's update timestamp
    @updated_at = @entries.first.updated_at if @entries.any?

    respond_to do |format|
      format.atom { render layout: false }

      # we want the RSS feed to redirect permanently to the ATOM feed
      format.rss { redirect_to feed_path(format: :atom), status: :moved_permanently }
    end
  end
end
