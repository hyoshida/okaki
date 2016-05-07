AwesomeAdminLayout.define(only: Admin::ApplicationController) do |controller|
  current_user = controller.current_user

  navigation do
    brand 'Okaki' do
      external_link controller.root_path
    end

    item 'Dashboard' do
      link controller.admin_root_path
      icon 'dashboard'
    end

    item 'Entries' do
      link '#' # controller.admin_entries_path
      icon 'cube'
    end

    item 'Users' do
      link controller.admin_users_path
      icon 'user'
    end

    divider

    item 'Settings' do
      link '#' # controller.admin_settings_path
      icon 'cog'
    end

    flex_divider

    item current_user.email do
      nest :profile
      icon 'gift'
    end
  end

  navigation :profile do
    brand current_user.email

    item 'Edit Profile' do
      link '#' # controller.admin_edit_user_path(current_user)
    end

    item 'Logout' do
      link '#' # controller.admin_destroy_user_session_path, method: :delete
    end
  end
end
