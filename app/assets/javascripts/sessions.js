$(function() {
  $("#email").focus();
  $('#form_login').validate({
    rules:{
      "user[email]":{
        required: true,
        email:true
      },
      "user[password]":{
        required: true
      }
    },
    messages:{
      "user[email]":{
        required: "Email is required.",
        email:"Please enter a valid email address."
      },
      "user[password]":{
        required: "Password is required."
      }
    },
    errorPlacement: function(label, element) {
      label.addClass('error-validattion-arrow');
      label.insertAfter(element);
    },
    wrapper: 'span'
  });
});