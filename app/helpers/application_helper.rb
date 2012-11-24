module ApplicationHelper

  # renders markdown, escaping premature HTML code before-hand
  def markdown(text)
    text = text.gsub(/</,'&lt;')
               .gsub(/>/,'&gt;')
               .to_soundcloud
               .to_spotify
    Redcarpet.new(text).to_html.html_safe
  end

  # gravatar
  def avatar_url(user)
    default_url = "#{root_url}assets/default_user.png"
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=64&d=#{CGI.escape(default_url)}"
  end
end
