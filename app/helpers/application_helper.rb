require 'net/http'
require 'json'

module ApplicationHelper

  # renders markdown, escaping premature HTML code before-hand
  def markdown(text)
    text = text.gsub(/</,'&lt;')
               .gsub(/>/,'&gt;')
               .hash_links
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

# TODO: better naming convention

class String
  # convert spotify URLs to embed code
  def to_spotify
    self.gsub(/^http:\/\/open.spotify.com\/track\/(.+)$/, 
      "<iframe src=\"https://embed.spotify.com/?uri=spotify:track:\\1\" width=\"550\" height=\"80\" frameborder=\"0\" allowtransparency=\"true\"></iframe>")
  end

  # convert soundcloud URLs to embed code
  def to_soundcloud
    # makes JSON call to soundcloud API to get embed code from URL
    # TODO: cache
    def fetch_code(url)
      fmt = URI.encode("http://soundcloud.com/oembed?format=json&url=#{url}&iframe=true")
      JSON.parse(Net::HTTP.get(URI.parse(fmt)))['html'] rescue url
    end
    self.gsub(/^https?:\/\/soundcloud.com\/(.+)\/(.+)$/) { |m| fetch_code m }
  end

  # convert hashtags to links
  def hash_links
    self.gsub(/#([a-zA-Z]+)\s*/, "<a href=\"/tagged/\\1\">#\\1</a> ")
  end
end
