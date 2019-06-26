class CreateJoinTablePhotosAlbums < ActiveRecord::Migration[5.2]
  def change
    create_join_table :photos, :albums do |t|
      # t.index [:photo_id, :album_id]
      # t.index [:album_id, :photo_id]
    end
  end
end
