$ ->
  $(document).on 'click', 'ul.public-profile-tabs li', ->
    tab_id = $(this).attr('data-tab')
    $('ul.public-profile-tabs li').removeClass 'current'
    $('.public-profile-tab-content').removeClass 'current'
    $(this).addClass 'current'
    $('#' + tab_id).addClass 'current'
    
  $(document).on 'click', 'a.please-login', ->
    toastr['error'] I18n.t('js.login_to_do_action')
    
  $(document).on 'ajax:error', '.a-person-card-follow', (event) ->
    detail = event.detail
    data = detail[0]
    toastr['error'] data