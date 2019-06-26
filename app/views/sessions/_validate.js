$(function() {
  $("#email").focus();
});
$('#form_login').validate({
  rules:{
    "email":{
      required: true,
      email:true
    },
    "password":{
      required: true
    }
  },
  messages:{
    email:{
      required: "Email is required.",
      email:"Please enter a valid email address."
    },
    password:{
      required: "Password is required."
    }
  },
  errorPlacement: function(label, element) {
        label.addClass('error-validattion-arrow');
        label.insertAfter(element);
    },
    wrapper: 'span',
    onfocusout: false,
    onkeyup: false,
    onclick: false
});