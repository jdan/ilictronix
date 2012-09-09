module ApplicationHelper

  # renders markdown, escaping premature HTML code before-hand
  def markdown(text)
    text = text.gsub(/</,'&lt;')
               .gsub(/>/,'&gt;')
    Redcarpet.new(text).to_html.html_safe
  end

end
