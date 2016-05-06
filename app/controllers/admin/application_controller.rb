module Admin
  class ApplicationController < ::ApplicationController
    before_action :authenticate_user!
    before_action :redirect_to_root_path, unless: -> { current_user.admin? }

    private

    def redirect_to_root_path
      redirect_to root_path
    end
  end
end
