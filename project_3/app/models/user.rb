class User < ApplicationRecord
  has_secure_password

  #Username/Password must be present, unique, and at least 6 letters long
  validates :email, presence: true, uniqueness: true, :length => {:within => 6..32}
  validates :password, presence: true, :length => {:within => 6..32}
end
