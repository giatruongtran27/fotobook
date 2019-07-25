$ ->
  jQuery.validator.addMethod 'uploadFile', (val, element) ->
    file = element.files[0]
    size = element.files[0].size
    type = element.files[0].type
    if type == 'image/jpeg' or type == 'image/png' or type == 'image/gif'
      if size > 5 * 1024 * 1024
        $('#photo_image').val ''
        return false
      else
        return true
    $('#photo_image').val ''
    false

  $(document).on 'click', '.img-preview-element a', ->
    $('#photo_image').val ''
    $(this).parent().remove()

  $('#photo_image').change ->
    if $x.element('#photo_image')
      file = $(this)[0].files[0]
      url = URL.createObjectURL(file)
      i_html = '<div class="img-preview-element">'
      i_html += '<img src="' + url + '" alt="avt" class="img-fluid img-thumbnail">'
      i_html += '<a href="javascript:;"><i class="fa fa-close"></i></a>'
      i_html += '</div>'
      $('#img_preview').removeClass('hidden').empty().append i_html
    else
      $('label#photo_image-error').text I18n.t('js.validate.please_upload_valid_image')
    
  $x = $('#form_new_photo').validate(
    rules:
      'photo[title]':
        required: true
        maxlength: 140
      'photo[description]':
        required: true
        maxlength: 300
      'photo[sharing_mode]': required: true
      'photo[image]':
        extension: 'jpe?g,png,gif'
        uploadFile: true
        required: true
    messages:
      'photo[title]':
        required: I18n.t('js.validate.title.required')
        maxlength: I18n.t('js.validate.title.maxlength')
      'photo[description]':
        required: I18n.t('js.validate.description.required')
        maxlength: I18n.t('js.validate.description.maxlength')
      'photo[sharing_mode]': 
        required: I18n.t('js.validate.sharing_mode.required')
      'photo[image]':
        extension: I18n.t('js.validate.image.extension')
        uploadFile: I18n.t('js.validate.image.invalid')
        required: I18n.t('js.validate.image.required')
    errorPlacement: (label, element) ->
      label.addClass 'error-validattion-arrow'
      label.insertAfter element
      return
    wrapper: 'span'
    onfocusout: false
    onfocus: false
    onkeyup: false
    onclick: false
  )
  $('#remove_img_edit_photo').click ->
    $(this).parent().addClass 'hidden'
    $('#col-input-file').removeClass('hidden').show()