class User < ApplicationRecord
  has_secure_password

  has_many :auditions
  has_many :projects

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password_digest, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

end
