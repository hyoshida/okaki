module Admin
  class ApplicationController < ::ApplicationController
    before_action :authenticate_user!
    before_action :redirect_to_root_path, unless: -> { current_user.admin? }

    prepend_around_action :disable_friendly_id

    private

    def redirect_to_root_path
      redirect_to root_path
    end

    def disable_friendly_id(&action)
      FriendlyId::Disabler.disable_friendly_id(&action)
    end
  end
end
