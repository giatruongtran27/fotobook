$(function() {
  $("#title").focus();
});
jQuery.validator.addMethod("uploadFile", function (val, element) {
  var file = element.files[0];
  // console.log(file);
  var size = element.files[0].size;
  var type = element.files[0].type;
  if(type == "image/jpeg" || type== "image/png"|| type == "image/gif"){
    if (size > 5*1024*1024)// checks the file more than 5 MB
    {
      // console.log("returning false");
      $('#customFile').val('');
      return false;
    } else {
        // console.log("returning true");
        return true;
      }
  }
    $('#customFile').val('');
    return false;
});
$(document).on("click", ".img-preview-element a" , function() {
    $('#customFile').val('');
    $(this).parent().remove();
});

$('#customFile').change(function () {
  // console.log($x.element("#customFile")==true);
  if($x.element("#customFile")){
    let file = $(this)[0].files[0];
    let url = URL.createObjectURL(file);
    let i_html = '<div class="img-preview-element">';
    i_html += '<img src="'+ url+'" alt="avt" class="img-fluid img-thumbnail">';
    i_html += '<a href="javascript:;"><i class="fa fa-close"></i></a>';
    i_html += '</div>';
    $('#img_preview').empty().append(i_html);
  }else{
    $('label#customFile-error').text('Please upload a valid image.');
  }
});

$x = $('#form_new_photo').validate({
  rules:{
    title:{
      required: true,
      maxlength: 140
    },
    description:{
      required: true,
      maxlength: 300
    },
    share_mode:{
      required: true
    },
    file: {
      extension:'jpe?g,png,gif',
      uploadFile:true,
      required: true
    }
  },
  messages:{
    title:{
      required: "Title is required.",
      maxlength: "Title must be less than 140 characters."
    },
    description:{
      required: "Description is required.",
      maxlength: "Description must be less than 300 characters."
    },
    share_mode:{
      required: "Share mode is required.",
    },
    file:{
      uploadFile: "Image is invalid.",
      required: "Image is required."
    }
  },
  errorPlacement: function(label, element) {
    label.addClass('error-validattion-arrow');
    label.insertAfter(element);
  },
  wrapper: 'span',
  onfocusout: false,
  onfocus:false,
  onkeyup: false,
  onclick: false,
  // submitHandler: function(form) {
  //   form.submit();
  // }
});


































