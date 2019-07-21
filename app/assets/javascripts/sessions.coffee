$ ->
  $('#form_login').validate
    rules:
      'user[email]':
        required: true
        email: true
      'user[password]': required: true
    messages:
      'user[email]':
        required: I18n.t('js.validate.email.required')
        email: I18n.t('js.validate.email.email')
      'user[password]': 
        required: I18n.t('js.validate.password.required')
    errorPlacement: (label, element) ->
      label.addClass 'error-validattion-arrow'
      label.insertAfter element
    wrapper: 'span'