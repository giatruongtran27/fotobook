$(function () {
  $('#form-edit-self-basic-info').validate({
    rules: {
      "user[email]": {
        required: true,
        email: true,
        maxlength: 255
      },
      "user[first_name]": {
        required: true,
        maxlength: 25
      },
      "user[last_name]": {
        required: true,
        maxlength: 25
      }
    },
    messages: {
      "user[email]": {
        required: "Email is required.",
        email: "Please enter a valid email address.",
        maxlength: "Email must be less than 255 characters."
      },
      "user[first_name]": {
        required: "First Name is required.",
        maxlength: "First Name must be less than 25 characters."
      },
      "user[last_name]": {
        required: "Last Name is required.",
        maxlength: "Last Name must be less than 25 characters."
      }
    },
    errorPlacement: function (label, element) {
      label.addClass('error-validattion-arrow');
      label.insertAfter(element);
    },
    wrapper: 'span',
  });
  $('#form-edit-self-password').validate({
    rules: {
      "user[current_password]":{
        required: true
      },
      "user[password]":{
        required: true,
        minlength: 6,
        maxlength: 64
      },
      "user[password_confirmation]":{
        required: true,
        equalTo: "#user_password"
      }
    },
    messages: {
      "user[current_password]":{
        required: "Current Password is required.",
      },
      "user[password]":{
        required: "Password is required.",
        minlength: "Password must be more than 6 characters.",
        maxlength: "Password must be less than 64 characters."
      },
      "user[password_confirmation]":{
        required: "Password Confirmation is required.",
        equalTo: "Password and password confirmation must be same."
      }
    },
    errorPlacement: function (label, element) {
      label.addClass('error-validattion-arrow');
      label.insertAfter(element);
    },
    wrapper: 'span',
  });
  $('#a_change_avatar').click(function(){
    $('form#form-edit-self-image').find('input[name="user[image]"]').click();
  });
  $('form#form-edit-self-image input[name="user[image]"]').change(function(){
    if ($i_check.element("#user_image")) {
      let file = $(this)[0].files[0];
      let url = URL.createObjectURL(file);
      $('#img_avatar').attr('src',url);
      $('form#form-edit-self-image').submit();
    }else{
      var errors = $i_check.errorList;
      for(var i=0; i<errors.length ;i++){
        toastr["error"](errors[i].message);
      }
    }
  });
  jQuery.validator.addMethod("uploadAvatarByYourself", function (val, element) {
    var file = element.files[0];
    var size = element.files[0].size;
    var type = element.files[0].type;
    errors = [];
    if (type == "image/jpeg" || type == "image/png" || type == "image/gif") {
      if (size > 5 * 1024 * 1024)// checks the file more than 5 MB
      {
        toastr["error"]("Max file size is 5MB.");
        return false;
      } else {
        return true;
      }
    }
    toastr["error"]("Please upload a valid image.");
    return false;
  });
  $i_check = $('form#form-edit-self-image').validate({
    rules:{
      "user[image]": {
        extension: 'jpe?g,png,gif',
        uploadAvatarByYourself: true
      }
    },
    messages:{
      "user[image]":{
        extension: "Image Type is invalid",
        uploadAvatarByYourself: "Image is invalid."
      }
    },
    errorPlacement: function(error,element) {
      return true;
    }
  });
});