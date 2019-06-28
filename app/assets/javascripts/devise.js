$(function() {
  //SIGNUP
  $("#user_email").focus();
  // $('#form_sign_up').trigger("reset");

  $('#new_user').validate({
    rules:{
      "user[email]":{
        required: true,
        email:true,
        maxlength:255
      },
      "user[first_name]":{
        required: true,
        maxlength: 25
      },
      "user[last_name]":{
        required: true,
        maxlength: 25
      },
      "user[password]":{
        required: true,
        maxlength: 64
      },
      "user[password_confirmation]":{
        required: true,
        equalTo: "#user_password"
      },

    },
    messages:{
      "user[email]":{
        required: "Email is required.",
        email:"Please enter a valid email address.",
        maxlength: "Email must be less than 255 characters."
      },
      "user[first_name]":{
        required: "First Name is required.",
        maxlength: "First Name must be less than 25 characters."
      },
      "user[last_name]":{
        required: "Last Name is required.",
        maxlength: "Last Name must be less than 25 characters."
      },
      "user[password]":{
        required: "Password is required.",
        maxlength: "Password must be less than 64 characters."
      },
      "user[password_confirmation]":{
        required: "Password Confirmation is required.",
        equalTo: "Password and password confirmation must be same."
      }
    },
    errorPlacement: function(label, element) {
      label.addClass('error-validattion-arrow');
      label.insertAfter(element);
    },
    wrapper: 'span',
    // onfocusout: false,
    // onkeyup: false,
    // onclick: false,
    submitHandler: function(form) {
      form.submit();
    }
  });

  $('#new_user button[type=submit]').click(function(e){
    alert("Cc");
    var isValid = $(e.target).parents('form').isValid();
    if(!isValid) {
      e.preventDefault(); //prevent the default action
    }
  });
  //END SIGNUP
});