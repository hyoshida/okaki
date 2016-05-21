AwesomeAdminLayout.define(only: Admin::ApplicationController) do |controller|
  current_user = controller.current_user

  navigation do
    brand Blog.instance.title do
      external_link controller.root_path
    end

    item 'Dashboard' do
      link controller.admin_root_path
      icon 'dashboard'
    end

    divider

    item 'Users' do
      link controller.admin_users_path
      icon 'user'
      active controller.controller_name == 'users' && controller.action_name != 'profile'
    end

    item 'Entries' do
      link controller.admin_entries_path
      icon 'file-text-o'
    end

    item 'Categories' do
      link controller.admin_categories_path
      icon 'tag'
    end

    item 'Assets' do
      link controller.admin_assets_path
      icon 'picture-o'
    end

    divider

    item 'Advertisements' do
      link controller.admin_advertisements_path
      icon 'bullhorn'
    end

    item 'Trackers' do
      link controller.admin_trackers_path
      icon 'area-chart'
    end

    divider

    item 'Settings' do
      link controller.admin_blog_path
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
      link controller.admin_profile_path
      active controller.controller_name == 'users' && controller.action_name == 'profile'
    end

    item 'Logout' do
      link controller.destroy_user_session_path, method: :delete
    end
  end
end
