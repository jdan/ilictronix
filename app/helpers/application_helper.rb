module ApplicationHelper

  def markdown(text)
    Redcarpet.new(text).to_html.html_safe
  end

end
