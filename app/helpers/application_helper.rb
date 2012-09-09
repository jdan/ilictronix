module ApplicationHelper

  def markdown(text)
    text.gsub!(/</,'&lt;')
        .gsub!(/>/,'&gt;')
    Redcarpet.new(text).to_html.html_safe
  end

end
