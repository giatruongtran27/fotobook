jQuery(function() {
  $(window).on('scroll', function() {
    if($('#tab-albums').hasClass('current')){
      if ($('.album-infinite-pagination').length > 0) {
        var more_posts_url = $('.album-infinite-pagination a.next_page').attr('href');
        var bottom_distance = 20;
        if (more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - bottom_distance) {
          $('.album-infinite-pagination').html('<div class="infinite-loading">loading...</div>');
          $.getScript(more_posts_url);
        }
      }
    }
    
    if($('#tab-photos').hasClass('current')){
      if ($('.photo-infinite-pagination').length > 0) {
        var more_posts_url = $('.photo-infinite-pagination a.next_page').attr('href');
        var bottom_distance = 20;
        if (more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - bottom_distance) {
          $('.photo-infinite-pagination').html('<div class="infinite-loading">loading...</div>');
          $.getScript(more_posts_url);
        }        
      }
    }
  });
});