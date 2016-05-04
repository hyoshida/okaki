module ApplicationHelper
  def gravatar_tag(user, options = {})
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    image_tag "//www.gravatar.com/avatar/#{gravatar_id}?default=mm", options
  end
end
