class User < ApplicationRecord

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, confirmation: true, presence: true, length: { minimum: 8 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validate :passwords_match

  def passwords_match
    if password != password_confirmation
      errors.add(:password_confirmation, "Passwords do not match")
    end
  end

  def self.authenticate_with_credentials(email, password)
    email = email.strip.downcase
    user = User.find_by(email: email)
  
    if user && user.authenticate(password)
      return user
    end
  
    return nil
  end

end
