# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

render_post = (data) ->
  post = $('#skeleton').children().clone()

  post.attr('id', data.dom_id)
  post.find('.date .month').text(data.date.month)
  post.find('.date .day').text(data.date.day)

  post.find('.else header .title a').text(data.title)
  post.find('.else header .title a').attr('href', '/' + data.slug)
  post.find('.else header > a').attr('href', '/' + data.slug + '#comments')
  post.find('.else header a .comments-count').text(data.comments_count)

  post.find('.else article').html(data.content)

  if (data.tags.length)
    tags_div = $('<div></div>').addClass('tags').text('Tagged: ')
    data.tags.forEach (tag) =>
      tag = $('<a></a>').attr('href', '/tagged/' + tag).text('#' + tag)
      tags_div.append("\n")
      tags_div.append(tag)

    post.find('.else article').append(tags_div)

  post

$ ->
  $('#post_submit').on 'click', ->
    $('#post_public').val('true')

  waiting = false

  $(window).scroll ->
    if !waiting && $(window).scrollTop() + $(window).height() == $(document).height()

      if $('#pageno').length
        page = parseInt($('#pageno').text())
        waiting = true
        $.getJSON '/posts/page/' + (page + 1) + '.json', (data) ->
          $('#pageno').text(page + 1)

          data.forEach (post) =>
            $('#skeleton').before(render_post(post))
          waiting = false

