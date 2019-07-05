class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :photos, dependent: :destroy
  has_many :albums, dependent: :destroy
  accepts_nested_attributes_for :albums
  # has_secure_password

  has_many :follower_follows, foreign_key: :followee_id, class_name: Follow.name
  has_many :followers, through: :follower_follows, source: :follower

  has_many :followee_follows, foreign_key: :follower_id, class_name: Follow.name
  has_many :followees, through: :followee_follows, source: :followee

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, length:{ maximum: 255 }, presence:true, uniqueness:{case_sensitive:false},format:{with:VALID_EMAIL_REGEX}
  validates :first_name, presence: true, length: {maximum: 25}
  validates :last_name, presence: true, length: {maximum: 25}
  # validates :password, presence: true, length: {in: 6..64}

  has_attached_file :image, styles: { medium: "300x300>", thumb: "150x150>" }, :default_url => "/assets/missing_avatar.png"
  # validates_attachment_presence :image
  # validates_attachment :image, content_type: { content_type: /\Aimage\/.*\z/ }, size: { less_than: 5.megabyte }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

end
