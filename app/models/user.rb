class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable, :recoverable
  devise :database_authenticatable, :rememberable, :trackable, :validatable

   # validation
  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  VALID_USERNAME_REGEX = /\A[A-Za-z0-9]+\z/i
  # Validation for attributes
  validates :username, :uniqueness => true, :presence => true, :format => VALID_USERNAME_REGEX
  validates :email, :presence => true, :length => { :maximum => 128 }, :format => VALID_EMAIL_REGEX

  enum plan: { free: 0, basic: 1, premium: 2 }
end
