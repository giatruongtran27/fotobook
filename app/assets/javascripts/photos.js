$(function () {
  $("#photo_title").focus();

  jQuery.validator.addMethod("uploadFile", function (val, element) {
    var file = element.files[0];
    // console.log(file);
    var size = element.files[0].size;
    var type = element.files[0].type;
    if (type == "image/jpeg" || type == "image/png" || type == "image/gif") {
      if (size > 5 * 1024 * 1024)// checks the file more than 5 MB
      {
        // console.log("returning false");
        $('#photo_image').val('');
        return false;
      } else {
        // console.log("returning true");
        return true;
      }
    }
    $('#photo_image').val('');
    return false;
  });
  $(document).on("click", ".img-preview-element a", function () {
    $('#photo_image').val('');
    $(this).parent().remove();
  });

  $('#photo_image').change(function () {
    // console.log($x.element("#photo_image")==true);
    if ($x.element("#photo_image")) {
      let file = $(this)[0].files[0];
      let url = URL.createObjectURL(file);
      let i_html = '<div class="img-preview-element">';
      i_html += '<img src="' + url + '" alt="avt" class="img-fluid img-thumbnail">';
      i_html += '<a href="javascript:;"><i class="fa fa-close"></i></a>';
      i_html += '</div>';
      $('#img_preview').removeClass('hidden').empty().append(i_html);
    } else {
      $('label#photo_image-error').text('Please upload a valid image.');
    }
  });

  $x = $('#form_new_photo').validate({
    rules: {
      "photo[title]": {
        required: true,
        maxlength: 140
      },
      "photo[description]": {
        required: true,
        maxlength: 300
      },
      "photo[sharing_mode]": {
        required: true
      },
      "photo[image]": {
        extension: 'jpe?g,png,gif',
        uploadFile: true,
        required: true
      }
    },
    messages: {
      "photo[title]": {
        required: "Title is required.",
        maxlength: "Title must be less than 140 characters."
      },
      "photo[description]": {
        required: "Description is required.",
        maxlength: "Description must be less than 300 characters."
      },
      "photo[sharing_mode]": {
        required: "Share mode is required.",
      },
      "photo[image]": {
        uploadFile: "Image is invalid.",
        required: "Image is required."
      }
    },
    errorPlacement: function (label, element) {
      label.addClass('error-validattion-arrow');
      label.insertAfter(element);
    },
    wrapper: 'span',
    onfocusout: false,
    onfocus: false,
    onkeyup: false,
    onclick: false,
    submitHandler: function (form) {
      form.submit();
    }
  });
  $('#remove_img_edit_photo').click(function () {
    // alert("cc");
    $(this).parent().addClass('hidden');
    $('#col-input-file').show();
  });
});