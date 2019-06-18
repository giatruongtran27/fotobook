$('#form_sign_up').validate({
	rules:{
		"email":{
			required: true,
			email:true,
			maxlength:255
		},
		"first_name":{
			required: true,
			maxlength: 25
		},
		"last_name":{
			required: true,
			maxlength: 25
		},
		"password":{
			required: true,
			maxlength: 64
		},
		"password_confirmation":{
			required: true,
			equalTo: "#pwd"
		},

	},
	messages:{
		email:{
			required: "Email is required.",
			email:"Please enter a valid email address.",
			maxlength: "Email must be less than 255 characters."
		},
		first_name:{
			required: "First Name is required.",
			maxlength: "First Name must be less than 25 characters."
		},
		last_name:{
			required: "Last Name is required.",
			maxlength: "Last Name must be less than 25 characters."
		},
		password:{
			required: "Password is required.",
			maxlength: "Password must be less than 64 characters."
		},
		password_confirmation:{
			required: "Password Confirmation is required.",
			equalTo: "Password and password confirmation must be same."
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