class Album < ApplicationRecord

  validates :title, presence: true, length: {maximum: 140}
  validates :description, presence: true, length: {maximum: 300}

  #1 : public
  #0 : private
  validates :sharing_mode, presence: true, inclusion: { in: [ 0, 1, true, false ] }

  belongs_to :user

  has_many :pics, dependent: :destroy
  # validates :album_images, :length => { :minimum => 1 }
end
