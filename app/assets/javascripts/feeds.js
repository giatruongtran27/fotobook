$(document).ready(function(){
  $('ul.tabs li').click(function(){
    var tab_id = $(this).attr('data-tab');

    $('ul.tabs li').removeClass('current');
    $('.tab-content').removeClass('current');

    $(this).addClass('current');
    $("#"+tab_id).addClass('current');
  });
  $('.element-a-flow').click(function(){
    var $this = $(this);
    if($this.text()==="flowing"){
      $this.removeClass("flowing");
      $this.text("flow");
    }else{
      $this.addClass("flowing");
      $this.text("flowing");
    }
  });

  $('.a-img-element').click(function(){
    var img = $(this).find('img').attr('src');
    var alt = $(this).find('img').attr('alt');
    $('#myModal .img-modal').attr('src',img);
    $('#myModal .img-modal').attr('alt',alt);
    var _right = $(this).siblings('.element-col-right');
    var _title = _right.find('.element-content-title');
    var _description = _right.find('.element-content-mid');
    var title = _title.text();
    var description = _description.text();
    $('#myModal h4.modal-title').text(title);
    $('#myModal p.modal-description').text(description);
  });

  $('a.element-album').click(function(){
    var imgs = $(this).children();
    $('#myModal2 .carousel-inner').empty();
    $.each(imgs, function( index, value ) {
      var v = $(value);
      // console.log(v);
      var i_html = "";
      var title = v.attr('data-title');
      var description = v.attr('data-description');
      if(index != imgs.length-1){
        i_html += '<div class="carousel-item">';
      }else{
        i_html += '<div class="carousel-item active">';
      }
      i_html += '<h5 class="modal-title">'+title+'</h5>';
      i_html += '<img src="'+ v.attr('src')+'"' + 'alt="'+ v.attr('alt')+'"' + 'class="img-fluid">';
      i_html += '<p class="modal-description">'+description+'</p>';
      i_html+= '</div>';
      $('#myModal2 .carousel-inner').append(i_html);
    });
    if(imgs.length<=1){
      $('#myModal2 .carousel-control-prev').hide();
      $('#myModal2 .carousel-control-next').hide();
    }else{
      $('#myModal2 .carousel-control-prev').show();
      $('#myModal2 .carousel-control-next').show();
    }
  });
})
