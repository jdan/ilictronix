# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#post_submit').on 'click', ->
    $('#post_public').val('true')

  # [sc:TITLE](SOUNDCLOUD_URL)
  # renders a soundcloud player client-side
  $('.post article a').each (i, v) ->
    if $(v).text().match(/^sc:/)
      $.getJSON('http://soundcloud.com/oembed?callback=?', { format: 'js', url: $(v).attr('href'), iframe: 'true' }, (data) ->
        $(v).after(data.html)
        $(v).remove()
      )
