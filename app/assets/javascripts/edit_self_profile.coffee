$ ->
  $('#form-edit-self-basic-info').validate
    rules:
      'user[email]':
        required: true
        email: true
        maxlength: 255
      'user[first_name]':
        required: true
        maxlength: 25
      'user[last_name]':
        required: true
        maxlength: 25
    messages:
      'user[email]':
        required: I18n.t('js.validate.email.required')
        email: I18n.t('js.validate.email.email')
        maxlength: I18n.t('js.validate.email.maxlength')
      'user[first_name]':
        required: I18n.t('js.validate.first_name.required')
        maxlength: I18n.t('js.validate.first_name.maxlength')
      'user[last_name]':
        required: I18n.t('js.validate.last_name.required')
        maxlength: I18n.t('js.validate.last_name.maxlength')
    errorPlacement: (label, element) ->
      label.addClass 'error-validattion-arrow'
      label.insertAfter element
    wrapper: 'span'
  $('#form-edit-self-password').validate
    rules:
      'user[current_password]': required: true
      'user[password]':
        required: true
        minlength: 6
        maxlength: 64
      'user[password_confirmation]':
        required: true
        equalTo: '#user_password'
    messages:
      'user[current_password]': 
        required: I18n.t('js.validate.current_password.required')
      'user[password]':
        required: I18n.t('js.validate.password.required')
        minlength: I18n.t('js.validate.password.minlength')
        maxlength: I18n.t('js.validate.password.maxlength')
      'user[password_confirmation]':
        required: I18n.t('js.validate.password_confirmation.required')
        equalTo: I18n.t('js.validate.password_confirmation.equalTo')
    errorPlacement: (label, element) ->
      label.addClass 'error-validattion-arrow'
      label.insertAfter element
    wrapper: 'span'
  $('#a_change_avatar').click ->
    $('form#form-edit-self-image').find('input[name="user[image]"]').click()
    
  $('form#form-edit-self-image input[name="user[image]"]').change ->
    if $i_check.element('#user_image')
      file = $(this)[0].files[0]
      url = URL.createObjectURL(file)
      $('#img_avatar').attr 'src', url
      $('form#form-edit-self-image').submit()
    else
      errors = $i_check.errorList
      i = 0
      while i < errors.length
        toastr['error'] errors[i].message
        i++

  jQuery.validator.addMethod 'uploadAvatarByYourself', (val, element) ->
    file = element.files[0]
    size = element.files[0].size
    type = element.files[0].type
    errors = []
    if type == 'image/jpeg' or type == 'image/png' or type == 'image/gif'
      if size > 5 * 1024 * 1024
        toastr['error'] I18n.t('js.validate.image.max_size')
        return false
      else
        return true
    toastr['error'] I18n.t('js.validate.please_upload_valid_image')
    false
  $i_check = $('form#form-edit-self-image').validate(
    rules: 'user[image]':
      extension: 'jpe?g,png,gif'
      uploadAvatarByYourself: true
    messages: 'user[image]':
      extension: I18n.t('js.validate.image.extension')
      uploadAvatarByYourself: I18n.t('js.validate.image.invalid')
    errorPlacement: (error, element) ->
      true
  )