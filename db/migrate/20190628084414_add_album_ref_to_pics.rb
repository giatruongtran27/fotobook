class AddAlbumRefToPics < ActiveRecord::Migration[5.2]
  def change
    add_reference :pics, :album, foreign_key: true
  end
end
