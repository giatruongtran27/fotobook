Dropzone.autoDiscover = false
$ ->
  # EDIT ALBUM WITH DROPZONE
  url_dropzone_album = $('#my-dropzone-album').attr('action')
  get_url_album_dropzone_pics = url_dropzone_album + '/list'
  $('#my-dropzone-album').dropzone
    maxFilesize: 5
    maxFiles: 25
    addRemoveLinks: true
    acceptedFiles: '.png,.jpg,.gif,.jpeg'
    paramName: 'pic[image]'
    success: (file, response) ->
      $(file.previewElement).find('.dz-remove').attr 'id', response.uploadId
      $(file.previewElement).addClass 'dz-success'
      toastr['success'] I18n.t("js.album.edit.add_image_to_album_success")
      return
    removedfile: (file) ->
      id = $(file.previewTemplate).find('.dz-remove').attr('id')
      u = $('#my-dropzone-album').attr('action')
      $.ajax
        type: 'DELETE'
        data: authenticity_token: $('[name="csrf-token"]')[0].content
        url: 'pics/' + id
        success: (data) ->
          toastr['info'] I18n.t("js.album.edit.remove_image_from_album_success")
          return
      previewElement = undefined
      if (previewElement = file.previewElement) != null then previewElement.parentNode.removeChild(file.previewElement) else undefined
    init: ->
      me = this
      $.get get_url_album_dropzone_pics, (data) ->
        $.each data.images, (key, value) ->
          if data.images != undefined and data.images.length > 0
            me.emit 'addedfile', value
            me.emit 'thumbnail', value, value.src
            me.emit 'complete', value
            $(value._removeLink).attr 'id', value.id