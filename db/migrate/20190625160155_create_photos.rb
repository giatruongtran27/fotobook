class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.string :title
      t.text :description
      # t.string :img_url
      t.boolean :sharing_mode, default: 1
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
