$(document).ready(function(){
  $('ul.tabs li').click(function(){
    var tab_id = $(this).attr('data-tab');

    $('ul.tabs li').removeClass('current');
    $('.tab-content').removeClass('current');

    $(this).addClass('current');
    $("#"+tab_id).addClass('current');
  });
  
  $('.element-a-follow').on('ajax:success',function(event){
    var detail = event.detail;
    var data = detail[0], status = detail[1],  xhr = detail[2];
    toastr["success"](data["messages"]);
    var a = $('a[href="'+$(this).attr('href')+'"]');
    var fol = a.toggleClass("following");
    if(fol.hasClass("following")) 
      fol.text("following");
    else fol.text("follow");
  });

  $('.element-a-follow').on('ajax:error',function(event){
    var detail = event.detail;
    var data = detail[0], status = detail[1],  xhr = detail[2];
    toastr["error"]("Action Error!" + data);
  });

  //LIKE
  $('.a-like').on('ajax:success',function(event){
    var detail = event.detail;
    var data = detail[0], status = detail[1],  xhr = detail[2];
    toastr["success"](data["messages"]);
    var fol = $(this).toggleClass("liked");
    var span_count_like = $(this).siblings('.count-like');
    var text_count_like = parseInt(span_count_like.text());

    if(data["type"]=="like"){
      text_count_like += 1;
      span_count_like.text(text_count_like);
    }else if(data["type"]=="unlike"){
      text_count_like -= 1;
      span_count_like.text(text_count_like);
    }
  });
  $('.a-like').on('ajax:error',function(event){
    var detail = event.detail;
    var data = detail[0], status = detail[1],  xhr = detail[2];
    toastr["error"]("error");
  });

  //Follow click on Feeds and Discover Page
  $(document).on('click','.a-img-element',function(){
  
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

  
  // Modal

  $('.element-album-main-image').on('ajax:success',function(){
    var detail = event.detail;
    var data = detail[0], status = detail[1],  xhr = detail[2];
    var pics = data["pics"];
    var has_images = data["has_images"]
    if(!has_images){
      toastr["info"](I18n.t("site.js.no_images_in_album"));
    }else{
      $('#myModal2 .carousel-inner').empty();
      $.each(pics,function(i){
        var pic = pics[i];
        var title = data['title'];
        var description = data['description'];
        var i_html = "";
        if(i==0){
          i_html += '<div class="carousel-item active">';
        }else{
          i_html += '<div class="carousel-item">';
        }
        i_html += '<h5 class="modal-title">'+title+'</h5>';
        i_html += '<img src="'+ pic.image +'"' + 'alt="'+ pic.title +'"' + 'class="img-fluid">';
        i_html += '<p class="modal-description">'+description+'</p>';
        i_html+= '</div>';
        $('#myModal2 .carousel-inner').append(i_html);
      });
      if (data["size_images"] <= 1){
        $('#myModal2 .carousel-control-prev').hide();
        $('#myModal2 .carousel-control-next').hide();
      }else{
        $('#myModal2 .carousel-control-prev').show();
        $('#myModal2 .carousel-control-next').show();
      }
      $('#myModal2').modal('show');
    }
  });
  $('.element-album-main-image').on('ajax:error',function(event){
    var detail = event.detail;
    var data = detail[0], status = detail[1],  xhr = detail[2];
    toastr["error"]("error");
  });
})
