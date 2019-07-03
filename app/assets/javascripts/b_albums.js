Dropzone.autoDiscover = false;
$(function () {
  /* ***************************** */
  /* EDIT ALBUM WITH DROPZONE */
  var url_dropzone_album = $('#my-dropzone-album').attr('action'); //current url
  var get_url_album_dropzone_pics = url_dropzone_album + '/list'; //url to get list pics of album
  $("#my-dropzone-album").dropzone({
    //autoProcessQueue: false,
    maxFilesize: 5,
    //parallelUploads: 5,
    maxFiles: 5,
    addRemoveLinks: true,
    acceptedFiles: ".png,.jpg,.gif,.jpeg",
    paramName: 'pic[image]',
    success: function (file, response) {
      $(file.previewElement).find('.dz-remove').attr('id', response.uploadId);
      $(file.previewElement).addClass('dz-success');
    },
    removedfile: function (file) {
      var id = $(file.previewTemplate).find('.dz-remove').attr('id');
      var u = $("#my-dropzone-album").attr('action');
      $.ajax({
        type: 'DELETE',
        data: { authenticity_token: $('[name="csrf-token"]')[0].content },
        url: "pics/" + id,
        success: function (data) {
          // console.log(data.message);
        }
      });
      var previewElement;
      return (previewElement = file.previewElement) != null ? (previewElement.parentNode.removeChild(file.previewElement)) : (void 0);
    },
    init: function() {
			var me = this;
			$.get( get_url_album_dropzone_pics, function(data) {
        // console.log(data);
        $.each(data.images, function(key, value) {
					if (data.images != undefined && data.images.length > 0) {
						me.emit("addedfile", value);
						me.emit("thumbnail", value, value.src);
						me.emit("complete", value);
            $(value._removeLink).attr("id", value.id);
					}
				});
			});
    }
  });
  /* ***************************** */
  /* ADD ALBUM*/
  $arr_imgs_valid_album = [];
  $arr_imgs_error_album = [];
  $('#album_pics_attributes_0_image').change(function(){
    var files = $('#album_pics_attributes_0_image')[0].files;
    console.log($album_new_validation.element("#album_pics_attributes_0_image"));
    // if ($album_new_validation.element("#album_pics_attributes_0_image")) {
    //   let file = $(this)[0].files[0];
    //   let url = URL.createObjectURL(file);
    //   let i_html = '<div class="img-preview-element">';
    //   i_html += '<img src="' + url + '" alt="avt" class="img-fluid img-thumbnail">';
    //   i_html += '<a href="javascript:;"><i class="fa fa-close"></i></a>';
    //   i_html += '</div>';
    //   $('#img_preview').removeClass('hidden').empty().append(i_html);
    // } else {
    //   $('label#photo_image-error').text('Please upload a valid image.');
    // }
    console.log("random",Math.random());
    console.log("valid",$arr_imgs_valid_album);
    console.log("error",$arr_imgs_error_album);
    for(var i=0; i<$arr_imgs_valid_album.length; i++){
      var a = $arr_imgs_valid_album[i];
      if(!a.added){
        let idx = $arr_imgs_valid_album[i].name;
        let file = $arr_imgs_valid_album[i].value;
        let url = URL.createObjectURL(file);
        let i_html = '<div class="img-preview-new-album" id='+idx+'>';
        i_html += '<img src="' + url + '" alt='+ file.name + ' width="200" class="img-fluid img-thumbnail">';
        i_html += '<div class="div-img-preview-album-gray"></div>';
        i_html += '<div class="div-img-preview-album-content">';
        i_html += '<p>'+ file.name +'</p>';
        i_html += '<small>'+ (file.size/(1024*1024)).toFixed(2) +'MB </small>';
        i_html += '</div>';
        i_html += '<a href="javascript:" class="remove-img-album-preview valid"><i class="fa fa-close"></i></a>';
        $('#album_image_preview').append(i_html);
        a.added = true;
      }
    }
    for(var i=0; i<$arr_imgs_error_album.length; i++){
      var a = $arr_imgs_error_album[i];
      if(!a.added){
        let idx = a.name;
        let file = a.value;
        let url = URL.createObjectURL(file);
        let i_html = '<div class="img-preview-new-album" id='+idx+'>';
        i_html += '<img src="' + url + '" alt='+ file.name +' width="200" class="img-fluid img-thumbnail bg-danger">';
        i_html += '<div class="div-img-preview-album-gray red"></div>';
        i_html += '<div class="div-img-preview-album-content">';
        i_html += '<p>'+ file.name +'</p>';
        i_html += '<small>'+ (file.size/(1024*1024)).toFixed(2) +'MB </small>';
        i_html += '</div>';
        i_html += '<a href="javascript:" class="remove-img-album-preview error"><i class="fa fa-close"></i></a>';
        $('#album_image_preview').append(i_html);
        a.added = true;
      }
    }
    $('#album_pics_attributes_0_image').val("");
  });
  $(document).on("click", ".remove-img-album-preview.valid", function (){
    console.log("valid",$arr_imgs_valid_album);
    console.log("error",$arr_imgs_error_album);
    var idx = $(this).parent().attr("id");
    $(this).parent().remove();
    $arr_imgs_valid_album = jQuery.grep($arr_imgs_valid_album, function(value) {
      return value.name != idx;
    });
    console.log("valid",$arr_imgs_valid_album);
    console.log("error",$arr_imgs_error_album);
  });
  $(document).on("click", ".remove-img-album-preview.error", function (){
    console.log("valid",$arr_imgs_valid_album);
    console.log("error",$arr_imgs_error_album);
    var idx = $(this).parent().attr("id");
    $(this).parent().remove();
    $arr_imgs_error_album = jQuery.grep($arr_imgs_error_album, function(value) {
      return value.name != idx;
    });
    console.log("valid",$arr_imgs_valid_album);
    console.log("error",$arr_imgs_error_album);
  });

  jQuery.validator.addMethod("uploadFilesAlbum", function (val, element) {
    var files = element.files;
    var length = element.files.length;
    var errors = [];
    for(var i=0; i<length;i++){
      var f = files[i];
      var size = f.size;
      var type = f.type;
      var ran = Math.random().toFixed(6).toString();
      var obj = {};
      obj.name = f.name + "-" + ran;
      obj.value = f;
      obj.added = false;
      if (type == "image/jpeg" || type == "image/png" || type == "image/gif") {
        if(size > 300000){// checks the file more than 5 MB // 5 * 1024 * 1024
          // $('#photo_image').val('');
          $arr_imgs_error_album.push(obj);
          errors.push(f);
          console.log(size);
          // return false;
        }else{
          // return true;
          $arr_imgs_valid_album.push(obj);
        }
      }else{
        errors.push(f);
        $arr_imgs_error_album.push(obj);
      }
    }
    //validate
    if (errors.length > 0) return false;
    else return true;
  });

  $album_new_validation = $('#form-add-album').validate({
    rules: {
      "album[title]": {
        required: true,
        maxlength: 140
      },
      "album[description]": {
        required: true,
        maxlength: 300
      },
      // share_mode: {
      //   required: true
      // },
      "pics[image][]": {
        uploadFilesAlbum: true,
      }
    },
    messages: {
      "album[title]": {
        required: "Title is required.",
        maxlength: "Title must be less than 140 characters."
      },
      "album[description]": {
        required: "Description is required.",
        maxlength: "Description must be less than 300 characters."
      },
      // share_mode: {
      //   required: "Share mode is required.",
      // },
      "pics[image][]": {
        uploadFilesAlbum: "You have invalid image."
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
    // submitHandler: function (form) {
    //   form.submit();
    // }
  });

  $('#form-add-album').submit(function(e){
    e.preventDefault();
    // console.log($album_new_validation);
    var form = $('#form-add-album').serializeArray();
    // var files = $('#album_pics_attributes_0_image')[0].files;
    var formData = new FormData();
    for(var i=0;i<form.length;i++){
      // console.log(form[i]);
      formData.append(form[i].name, form[i].value);
    }
    for(var i = 0; i<$arr_imgs_valid_album.length;i++){
      // console.log(files[i]);
      console.log($arr_imgs_valid_album[i]);
      formData.append('pics[image][]',$arr_imgs_valid_album[i].value);
    }
    var u = $('#form-add-album').attr('action');
    if($arr_imgs_valid_album.length > 25){
      toastr["error"]("Please upload maximum 25 images!")
    }else{
      $.ajax({
        url: u,
        data:formData,
        type: 'POST',
        contentType: false,
        processData: false,
        success: function(){
          console.log("success");
        }
      });
    }
  });
  /* ***************************** */
});