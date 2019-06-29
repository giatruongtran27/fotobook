class Pic < ApplicationRecord
  # has_attached_file :image
  has_attached_file :image, styles: { medium: "300x300>", thumb: "150x150>" }, default_url: "/images/:style/missing.png"
  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\z/ }, size: { less_than: 5.megabyte }
  
  belongs_to :album

  # validates_attachment_presence :image
  # validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']
end
