$(function(){
  // TAB PUBLIC PROFILE
  $(document).on('click','ul.public-profile-tabs li',function(){
    var tab_id = $(this).attr('data-tab');
    $('ul.public-profile-tabs li').removeClass('current');
    $('.public-profile-tab-content').removeClass('current');

    $(this).addClass('current');
    $("#"+tab_id).addClass('current');
  });

  //PUBLIC PROFILE CLICK FOLLOW
  $(document).on('click','a.please-login',function(){
    toastr["error"](I18n.t("site.js.login_to_do_action"));
  });

  $(document).on('ajax:error','.a-person-card-follow',function(event){
    var detail = event.detail;    
    var data = detail[0], status = detail[1],  xhr = detail[2];
    toastr["error"]("Action Error!");
  });
});

