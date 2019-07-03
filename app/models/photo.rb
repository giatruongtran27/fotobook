class Photo < ApplicationRecord

  has_attached_file :image

  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\z/ }, size: { less_than: 5.megabyte }
  validates :title, presence: true, length: {maximum: 140}
  validates :description, presence: true, length: {maximum: 300}
  #1 : public
  #0 : private
  validates :sharing_mode, presence: true, inclusion: { in: [ 0, 1, true, false] }

  belongs_to :user
  # has_and_belongs_to_many :albums

end
