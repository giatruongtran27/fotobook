$(function(){
  // TAB PUBLIC PROFILE
  $('ul.public-profile-tabs li').click(function(){
    var tab_id = $(this).attr('data-tab');

    $('ul.public-profile-tabs li').removeClass('current');
    $('.public-profile-tab-content').removeClass('current');

    $(this).addClass('current');
    $("#"+tab_id).addClass('current');
  });
  // end TAB

  //PUBLIC PROFILE CLICK FOLLOW
  follow_click = function(e, own = 0){
    var _this = $(e);
    if(own==1){
      var un = _this.toggleClass("unfollow");
      if(un.hasClass("unfollow")) un.text("unfollow");
      else un.text("follow");
    }else{
      var fol =_this.toggleClass("following");
      if(fol.hasClass("following")) fol.text("following");
      else fol.text("follow");
    }
  }

  $(document).on('ajax:success','.a-person-card-follow',function(event){
    var detail = event.detail;
    var data = detail[0], status = detail[1],  xhr = detail[2];
    console.log(data);
    toastr["success"](data["messages"]);
    _counts_followings_tab = parseInt($('#counts-followings-tab').text());
    _counts_followers_tab = parseInt($('#counts-followers-tab').text());
    _check_in_followings_tab = $(this).parents('div#tab-followings').length ? true : false;
    _check_in_followers_tab = $(this).parents('div#tab-followers').length ? true : false;
    if(data["check_its_you_action_to_other_profile"]){ // you do action follow when visit a profile user at the head
      if(data["type"]=="unfollow"){
        $('#counts-followers-tab').text(_counts_followers_tab - 1);
        var you = data['you'];
        var id = "its_you_follow_" + you.your_profile.id; 
        var a = $('button#'+id);
        a.parents('div.followers-card').remove();
      }else if(data["type"]=="follow"){
        $('#counts-followers-tab').text(_counts_followers_tab + 1);
        var container = $('.profiles-content-wrapper-followers');
        var you = data['you'];
        // append your profile to followings tabs of this user you have followed
        let i_html = '<div class="d-flex flex-column followers-card">';
        i_html += '<div class="p-2 text-center">';
        i_html += '<a class="a-person" href="javascript:;">';
        i_html += '<img src='+ you.your_image +' alt="'+ you.your_profile.last_name +'" class="rounded-circle" width="100" height="100">';
        i_html += '</a>';
        i_html += '</div>';
        i_html += '<h5 class="text-center a-person-name">'+ you.your_profile.last_name + " " + you.your_profile.first_name +'</h5>';
        i_html += '<div class="d-flex justify-content-around mb-1">';
        i_html += '<div class="d-flex flex-fill flex-column a-person-card-photos">';
        i_html += '<p>'+ you.your_photos +'</p>';
        i_html += '<small>PHOTOS</small>';
        i_html += '</div>';
        i_html += '<div class="d-flex flex-fill flex-column a-person-card-albums">';
        i_html += '<p>'+ you.your_albums +'</p>';
        i_html += '<small>ALBUMS</small>';
        i_html += '</div>';
        i_html += '</div>';
        i_html += '<div class="text-center">';
        i_html += '<button href="javascript:;" class="a-person-card-follow following" id="its_you_follow_'+ you.your_profile.id +'">it\'s you</button>';
        i_html += '</div>';
        i_html += '</div>';
        // 
        container.append(i_html);
      }
    }else{ // you do action follow to another users when visit a profile's tags //followings tabs// followers tabs
      if(data["check_is_this_user"]){ // check if you are in your profile page
        if(data["type"]=="unfollow"){ // unfollow action
          $('#counts-followings-tab').text(_counts_followings_tab - 1);
          if (_check_in_followings_tab){
            dup = $('div#tab-followers').find('a[href="'+$(this).attr('href')+'"]');
            dup.toggleClass("following").text("follow");
            $(this).parents('.followings-card').remove();
          } else if (_check_in_followers_tab){
            _a = $('div#tab-followings').find('a[href="'+$(this).attr('href')+'"]');
            _a.parents('.followings-card').remove();
          }
        }else if (data["type"]=="follow"){ // follow action
          $('#counts-followings-tab').text(_counts_followings_tab + 1);
          if (_check_in_followers_tab){
            var p = $(this).parents('div.followers-card');
            var out_p = p[0].outerHTML;
            var container = $('div#tab-followings').find('.profiles-content-wrapper-followings');
            container.append(out_p);
            var last = container.children().last();
            last.removeClass('followers-card').addClass("followings-card");
            last.find('a[href="'+$(this).attr('href')+'"]').removeClass("following").addClass("unfollow").text("unfollow");
          }
        }
      }
    }
  });

  $(document).on('ajax:error','.a-person-card-follow',function(event){
    var detail = event.detail;    
    var data = detail[0], status = detail[1],  xhr = detail[2];
    console.log("error",data);
    toastr["error"]("Action Error!");
  });

});

