class Pic < ApplicationRecord
  # has_attached_file :image
  belongs_to :album, optional: true

  has_attached_file :image, styles: { medium: "300x300>", thumb: "150x150>" }, default_url: "/images/:style/missing.png"
  # validates_attachment :image, content_type: { content_type: /\Aimage\/.*\z/ }, size: { less_than: 5.megabyte }
  # validates_attachment_presence :image
  
  # has_attached_file :attachment, styles:  { thumb: "100x100!", medium: "200x200!" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  # validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']
end
