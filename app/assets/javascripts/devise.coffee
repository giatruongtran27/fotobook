$ ->
  $('#new_user').validate
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
      'user[password]':
        required: true
        maxlength: 64
      'user[password_confirmation]':
        required: true
        equalTo: '#user_password'
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
      'user[password]':
        required: I18n.t('js.validate.password.required')
        maxlength: I18n.t('js.validate.password.maxlength')
      'user[password_confirmation]':
        required: I18n.t('js.validate.password_confirmation.required')
        equalTo: I18n.t('js.validate.password_confirmation.equalTo')
    errorPlacement: (label, element) ->
      label.addClass 'error-validattion-arrow'
      label.insertAfter element
      return
    wrapper: 'span'

  $('#new_user button[type=submit]').click (e) ->
    isValid = $(e.target).parents('form').isValid()
    if !isValid
      return