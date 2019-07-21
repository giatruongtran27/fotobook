$(document).ready ->
  $(document).on 'click', 'ul.tabs li', ->
    tab_id = $(this).attr('data-tab')
    $('ul.tabs li').removeClass 'current'
    $('.tab-content').removeClass 'current'
    $(this).addClass 'current'
    $('#' + tab_id).addClass 'current'

  $(document).on 'ajax:error', '.element-a-follow', (event) ->
    detail = event.detail
    data = detail[0]
    toastr['error'] I18n.t('js.validate.try_again') + data
  
  #Like
  $(document).on 'ajax:success', '.a-like', (event) ->
    detail = event.detail
    data = detail[0]
    toastr['success'] data['messages']
    fol = $(this).toggleClass('liked')
    span_count_like = $(this).siblings('.count-like')
    text_count_like = parseInt(span_count_like.text())
    if data['type'] == 'like'
      text_count_like += 1
      span_count_like.text text_count_like
    else if data['type'] == 'unlike'
      text_count_like -= 1
      span_count_like.text text_count_like
  
  $(document).on 'ajax:error', '.a-like', (event) ->
    toastr['error'] I18n.t('js.validate.try_again')
  
  #Modal Photo
  $(document).on 'click', '.a-img-element', ->
    img = $(this).find('img').attr('src')
    alt = $(this).find('img').attr('alt')
    $('#myModal .img-modal').attr 'src', img
    $('#myModal .img-modal').attr 'alt', alt
    _right = $(this).siblings('.element-col-right')
    _title = _right.find('.element-content-title')
    _description = _right.find('.element-content-mid')
    title = _title.text()
    description = _description.text()
    $('#myModal h4.modal-title').text title
    $('#myModal p.modal-description').text description
  
  # Modal Album
  $(document).on 'ajax:success', '.element-album-main-image', (event) ->
    detail = event.detail
    data = detail[0]
    status = detail[1]
    xhr = detail[2]
    pics = data['pics']
    has_images = data['has_images']
    if !has_images
      toastr['info'] I18n.t('js.no_images_in_album')
    else
      $('#myModal2 .carousel-inner').empty()
      $.each pics, (i) ->
        pic = pics[i]
        title = data['title']
        description = data['description']
        i_html = ''
        if i == 0
          i_html += '<div class="carousel-item active">'
        else
          i_html += '<div class="carousel-item">'
        i_html += '<h5 class="modal-title">' + title + '</h5>'
        i_html += '<img src="' + pic.image + '"' + 'alt="' + pic.title + '"' + 'class="img-fluid">'
        i_html += '<p class="modal-description">' + description + '</p>'
        i_html += '</div>'
        $('#myModal2 .carousel-inner').append i_html
        return
      if data['size_images'] <= 1
        $('#myModal2 .carousel-control-prev').hide()
        $('#myModal2 .carousel-control-next').hide()
      else
        $('#myModal2 .carousel-control-prev').show()
        $('#myModal2 .carousel-control-next').show()
      $('#myModal2').modal 'show'
    
  $(document).on 'ajax:error', '.element-album-main-image', (event) ->
    toastr['error'] I18n.t('js.validate.try_again')