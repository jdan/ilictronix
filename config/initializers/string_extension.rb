require 'net/http'
require 'json'

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
      JSON.parse(Net::HTTP.get(URI.parse(fmt)))['html']
    end
    self.gsub(/^http:\/\/soundcloud.com\/(.+)\/(.+)$/) { |m| fetch_code m }
  end
end