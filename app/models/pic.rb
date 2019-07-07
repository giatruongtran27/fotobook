class Pic < ApplicationRecord
  belongs_to :album, optional: true
  has_attached_file :image, styles: { medium: "300x300>", thumb: "150x150>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  # validates_attachment :image, content_type: { content_type: /\Aimage\/.*\z/ }, size: { less_than: 5.megabyte }, ['image/jpeg', 'image/png']
end
