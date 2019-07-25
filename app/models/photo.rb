class Photo < ApplicationRecord
  enum sharing_mode: {public_mode: true , private_mode: false}
  has_attached_file :image, styles: { medium: "300x300>", thumb: "150x150>" }
  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\z/ }, size: { less_than: 5.megabyte }
  validates :title, presence: true, length: {maximum: 140}
  validates :description, presence: true, length: {maximum: 300}
  validates :sharing_mode, presence: true

  belongs_to :user
  # has_and_belongs_to_many :albums
  has_many :likes, as: :likeable


end
