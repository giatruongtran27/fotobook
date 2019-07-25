$ ->
  $arr_imgs_valid_album = []
  $arr_imgs_error_album = []
  show_preview_images_album = (arr, type) ->
    i = 0
    while i < arr.length
      a = arr[i]
      if !a.added
        idx = a.name
        file = a.value
        url = URL.createObjectURL(file)
        i_html = '<div class="img-preview-new-album" id=' + idx + '>'
        i_html += '<img src="' + url + '" alt=' + file.name + ' width="200" class="img-fluid img-thumbnail'
        if type == 'error'
          i_html += ' bg-danger'
        i_html += '">'
        i_html += '<div class="div-img-preview-album-gray'
        if type == 'error'
          i_html += ' red'
        i_html += '"></div>'
        i_html += '<div class="div-img-preview-album-content">'
        i_html += '<p>' + file.name + '</p>'
        i_html += '<small>' + (file.size / (1024 * 1024)).toFixed(2) + 'MB </small>'
        i_html += '</div>'
        i_html += '<a href="javascript:" class="remove-img-album-preview'
        if type == 'valid'
          i_html += ' valid"><i class="fa fa-close"></i></a>'
        else
          i_html += ' error"><i class="fa fa-close"></i></a>'
        $('#album_image_preview').append i_html
        a.added = true
      i++

  $('#album_pics_attributes_0_image').change ->
    files = $('#album_pics_attributes_0_image')[0].files
    $album_new_validation.element '#album_pics_attributes_0_image'
    #call validation
    show_preview_images_album $arr_imgs_valid_album, 'valid'
    show_preview_images_album $arr_imgs_error_album, 'error'
    $('#album_pics_attributes_0_image').val ''

  $(document).on 'click', '.remove-img-album-preview', ->
    idx = $(this).parent().attr('id')
    if $(this).hasClass('valid')
      $arr_imgs_valid_album = jQuery.grep($arr_imgs_valid_album, (value) ->
        value.name != idx
      )
    else if $(this).hasClass('error')
      $arr_imgs_error_album = jQuery.grep($arr_imgs_error_album, (value) ->
        value.name != idx
      )
    $(this).parent().remove()

  jQuery.validator.addMethod 'uploadFilesAlbum', (val, element) ->
    files = element.files
    length = element.files.length
    errors = []
    i = 0
    while i < length
      f = files[i]
      size = f.size
      type = f.type
      ran = Math.random().toFixed(6).toString()
      obj = {}
      obj.name = f.name + '-' + ran
      obj.value = f
      obj.added = false
      if type == 'image/jpeg' or type == 'image/png' or type == 'image/gif'
        if size > 5 * 1024 * 1024
          # checks the file more than 5 MB // 5 * 1024 * 1024
          $arr_imgs_error_album.push obj
          errors.push f
        else
          $arr_imgs_valid_album.push obj
      else
        errors.push f
        $arr_imgs_error_album.push obj
      i++
    if errors.length > 0
      false
    else
      true

  $album_new_validation = $('#form-add-album').validate(
    rules:
      'album[title]':
        required: true
        maxlength: 140
      'album[description]':
        required: true
        maxlength: 300
      'album[sharing_mode]': 
        required: true
      'pics[image][]': 
        uploadFilesAlbum: true
    messages:
      'album[title]':
        required: I18n.t('js.validate.title.required')
        maxlength: I18n.t('js.validate.title.maxlength')
      'album[description]':
        required: I18n.t('js.validate.description.required')
        maxlength: I18n.t('js.validate.description.maxlength')
      'album[sharing_mode]': 
        required: I18n.t('js.validate.sharing_mode.required')
      'pics[image][]': 
        uploadFilesAlbum: I18n.t('js.validate.uploadFilesAlbum')
    errorPlacement: (label, element) ->
      label.addClass 'error-validattion-arrow'
      label.insertAfter element
    wrapper: 'span'
    onfocusout: false
    onfocus: false
    onkeyup: false
    onclick: false)

  send_form = ->
    form = $('#form-add-album').serializeArray()
    formData = new FormData
    i = 0
    while i < form.length
      formData.append form[i].name, form[i].value
      i++
    i = 0
    while i < $arr_imgs_valid_album.length
      formData.append 'pics[image][]', $arr_imgs_valid_album[i].value
      i++
    u = $('#form-add-album').attr('action')
    if $arr_imgs_valid_album.length > 25
      toastr['error'] I18n.t('js.validate.max_25_images')
    else
      $.ajax
        url: u
        data: formData
        type: 'POST'
        contentType: false
        processData: false
        beforeSend: ->
          $('#preload').fadeIn 'fast'
        success: ->
          $('#preload').fadeOut 'fast'
        error: ->
          $('#preload').fadeOut 'fast'

  $('#form-add-album').submit (e) ->
    e.preventDefault()
    is_valid = $('#form-add-album').valid()
    if !is_valid
      toastr['error'] I18n.t('js.validate.try_again')
    else
      Swal.fire(
        title: I18n.t('js.validate.you_will_create_album')
        text: I18n.t('js.validate.only_accept_valid_images')
        type: 'warning'
        showCancelButton: true
        confirmButtonText: I18n.t('js.validate.accept')
        cancelButtonText: I18n.t('js.validate.cancel')).then (result) ->
        if result.value
          send_form()
        else if result.dismiss == Swal.DismissReason.cancel
          Swal.fire I18n.t('js.validate.cancelled'), I18n.t('js.validate.you_can_redo_somethings'), 'success'
          $('#form-add-album #btn-add-album-submit').prop('disabled', false);