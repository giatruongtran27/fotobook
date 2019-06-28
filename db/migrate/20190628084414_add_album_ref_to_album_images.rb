class AddAlbumRefToAlbumImages < ActiveRecord::Migration[5.2]
  def change
    add_reference :album_images, :album, foreign_key: true
  end
end
