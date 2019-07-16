Dropzone.autoDiscover = false;
$(function () {
  /* EDIT ALBUM WITH DROPZONE */
  var url_dropzone_album = $('#my-dropzone-album').attr('action'); //current url
  var get_url_album_dropzone_pics = url_dropzone_album + '/list'; //url to get list pics of album
  $("#my-dropzone-album").dropzone({
    maxFilesize: 5,
    maxFiles: 25,
    addRemoveLinks: true,
    acceptedFiles: ".png,.jpg,.gif,.jpeg",
    paramName: 'pic[image]',
    success: function (file, response) {
      $(file.previewElement).find('.dz-remove').attr('id', response.uploadId);
      $(file.previewElement).addClass('dz-success');
      toastr["success"]("Add image to this album successfully.");
    },
    removedfile: function (file) {
      var id = $(file.previewTemplate).find('.dz-remove').attr('id');
      var u = $("#my-dropzone-album").attr('action');
      $.ajax({
        type: 'DELETE',
        data: { authenticity_token: $('[name="csrf-token"]')[0].content },
        url: "pics/" + id,
        success: function (data) {
          toastr["info"]("Remove image from this album successfully.");
        }
      });
      var previewElement;
      return (previewElement = file.previewElement) != null ? (previewElement.parentNode.removeChild(file.previewElement)) : (void 0);
    },
    init: function() {
			var me = this;
			$.get( get_url_album_dropzone_pics, function(data) {
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

  /* ADD ALBUM*/
  $('#album_title').focus();
  $arr_imgs_valid_album = [];
  $arr_imgs_error_album = [];
  show_preview_images_album = function(arr,type){
    for(var i=0; i<arr.length; i++){
      var a = arr[i];
      if(!a.added){
        let idx = a.name;
        let file = a.value;
        let url = URL.createObjectURL(file);
        let i_html = '<div class="img-preview-new-album" id='+idx+'>';
        i_html += '<img src="' + url + '" alt='+ file.name + ' width="200" class="img-fluid img-thumbnail';
        if(type=="error") i_html += " bg-danger";
        i_html += '">';
        i_html += '<div class="div-img-preview-album-gray'; 
        if(type=="error") i_html += " red";
        i_html += '"></div>';
        i_html += '<div class="div-img-preview-album-content">';
        i_html += '<p>'+ file.name +'</p>';
        i_html += '<small>'+ (file.size/(1024*1024)).toFixed(2) +'MB </small>';
        i_html += '</div>';
        i_html += '<a href="javascript:" class="remove-img-album-preview';
        if(type=="valid") i_html +=' valid"><i class="fa fa-close"></i></a>';
        else i_html +=' error"><i class="fa fa-close"></i></a>';
        $('#album_image_preview').append(i_html);
        a.added = true;
      }
    }
  }
  $('#album_pics_attributes_0_image').change(function(){
    var files = $('#album_pics_attributes_0_image')[0].files;
    $album_new_validation.element("#album_pics_attributes_0_image"); //call validation
    show_preview_images_album($arr_imgs_valid_album,"valid");
    show_preview_images_album($arr_imgs_error_album,"error");
    $('#album_pics_attributes_0_image').val("");
  });
  $(document).on("click", ".remove-img-album-preview", function (){
    var idx = $(this).parent().attr("id");
    if($(this).hasClass("valid")){
      $arr_imgs_valid_album = jQuery.grep($arr_imgs_valid_album, function(value) {
        return value.name != idx;
      });
    }else if($(this).hasClass("error")){
      $arr_imgs_error_album = jQuery.grep($arr_imgs_error_album, function(value) {
        return value.name != idx;
      });
    }
    $(this).parent().remove();
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
        if(size > (5*1024*1024)){// checks the file more than 5 MB // 5 * 1024 * 1024
          $arr_imgs_error_album.push(obj);
          errors.push(f); // return false;
        }else{
          $arr_imgs_valid_album.push(obj); // return true;
        }
      }else{
        errors.push(f);
        $arr_imgs_error_album.push(obj);
      }
    }
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
      "album[sharing_mode]": {
        required: true
      },
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
      "album[sharing_mode]": {
        required: "Share mode is required.",
      },
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
    onclick: false
  });

  $('#form-add-album').submit(function(e){
    e.preventDefault();
    var is_valid = $('#form-add-album').valid();
    if(!is_valid) {
      toastr["error"]("Error");
    }else{
      var form = $('#form-add-album').serializeArray();
      var formData = new FormData();
      for(var i=0;i<form.length;i++){
        formData.append(form[i].name, form[i].value);
      }
      for(var i = 0; i<$arr_imgs_valid_album.length;i++){
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
          beforeSend: function(){
            $('#preload').fadeIn('fast');
          },
          success: function(){
            $('#preload').fadeOut('fast'); // success
          },
          error:function(){
            $('#preload').fadeOut('fast'); // error
          }
        });
      }
    } 
  });
});