class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  has_many :photos, dependent: :destroy

  has_many :albums, dependent: :destroy

  # has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, length:{ maximum: 255 }, presence:true, uniqueness:{case_sensitive:false},format:{with:VALID_EMAIL_REGEX}
  validates :first_name, presence: true, length: {maximum: 25}
  validates :last_name, presence: true, length: {maximum: 25}
  validates :password, presence: true, length: {in: 6..64}

end
