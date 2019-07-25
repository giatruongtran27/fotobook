jQuery ->
  paginate = (obj_paginattion) ->
    obj = $('.' + obj_paginattion)
    if obj.length > 0
        more_posts_url = obj.find('a.next_page').attr('href')
        bottom_distance = 20
        if more_posts_url and $(window).scrollTop() > $(document).height() - $(window).height() - bottom_distance
          obj.html '<div class="infinite-loading">loading...</div>'
          $.getScript more_posts_url
  $(window).on 'scroll', ->
    if $('#tab-albums').hasClass('current')
      paginate('album-infinite-pagination')
    if $('#tab-photos').hasClass('current')
      paginate('photo-infinite-pagination')