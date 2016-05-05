module ApplicationHelper
  def gravatar_tag(user, options = {})
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    image_tag "//www.gravatar.com/avatar/#{gravatar_id}?default=mm", options
  end

  def syntax_highlight(html)
    doc = Nokogiri::HTML(html)
    doc.search('pre').each do |pre|
      lang = pre.children.attribute('class').try(:value) || :bash
      code = CodeRay.scan(pre.text.strip, lang).div
      pre.replace(code)
    end
    doc.to_s.html_safe
  end
end
