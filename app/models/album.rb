class Album < ApplicationRecord
  enum sharing_mode: {public_mode: true , private_mode: false}
  validates :title, presence: true, length: {maximum: 140}
  validates :description, presence: true, length: {maximum: 300}
  validates :sharing_mode, presence: true

  belongs_to :user, optional: true
  has_many :pics
  accepts_nested_attributes_for :pics
  validates_associated :pics
  has_many :likes, as: :likeable

end
