module ApplicationHelper
  def gravatar_tag(user, options = {})
    size = options.delete(:size) || 80
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    image_tag "//www.gravatar.com/avatar/#{gravatar_id}?default=mm&size=#{size}", options
  end

  def syntax_highlight(html)
    doc = Nokogiri::HTML(html)
    doc.search('pre').each do |pre|
      lang = pre.children.attribute('class').try(:value) || :text
      code = CodeRay.scan(pre.text.strip, lang).div
      pre.replace(code)
    end
    doc.to_s.html_safe
  end

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true,
      tables: true
    }
    html = Redcarpet::Markdown.new(renderer, options).render(text)
    syntax_highlight(html).html_safe
  end

  def editor_mode?
    controller_name == 'entries' && action_name.in?(['new', 'edit'])
  end

  def page_name
    [controller_name, action_name].join(':')
  end
end
