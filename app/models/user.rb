class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :database_authenticatable, :rememberable, :validatable
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable, :recoverable
  devise :trackable, :omniauthable, :omniauth_providers => [:twitter]

   # validation
  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  VALID_USERNAME_REGEX = /\A[A-Za-z0-9]+\z/i
  # Validation for attributes
  validates :username, :uniqueness => true, :presence => true
  #validates :email, :presence => true, :length => { :maximum => 128 }

  enum plan: { free: 0, premium: 1 }
end
