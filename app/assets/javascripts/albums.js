Dropzone.autoDiscover = false;
$(function () {
  $("#my-dropzone-album").dropzone({
    maxFilesize: 2,
    addRemoveLinks: true,
    paramName: 'photo[image]',
    success: function(file, response) {
      $(file.previewElement).find('.dz-remove').attr('id', response.uploadId);
      $(file.previewElement).addClass('dz-success');
    },
    removedfile: function(file) {
      var id = $(file.previewTemplate).find('.dz-remove').attr('id');
      var u = $("#my-dropzone-album").attr('action');
      $.ajax({
        type: 'DELETE',
        url: "album-image/" + id,
        success: function(data) {
          console.log(data.message);
        }
      });

      var previewElement;
      return (previewElement = file.previewElement) != null ? (previewElement.parentNode.removeChild(file.previewElement)) : (void 0);
    },
    // init: function() {
    //   this.on("processing", function(file) {
    //     this.options.url = "/albums/:id/add/";
    //   });
    // }
  });
});