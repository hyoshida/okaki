module ApplicationHelper
  def gravatar_tag(user, options = {})
    size = options.delete(:size) || 80
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    image_tag "//www.gravatar.com/avatar/#{gravatar_id}?default=mm&size=#{size}", options
  end

  def editor_mode?
    controller_name == 'entries' && action_name.in?(['new', 'edit', 'create', 'update'])
  end

  def page_name
    [controller_name, action_name].join(':')
  end
end
