class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :title
      t.text :description
      t.boolean :sharing_mode
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
