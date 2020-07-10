class User < ApplicationRecord
  has_many :articles
  has_secure_password

  before_save { self.email = email.downcase }
  
  validates :email, 
    format: { with: URI::MailTo::EMAIL_REGEXP },
    :uniqueness => { :case_sensitive => true, :message => "is taken" }

  validates :username, 
    :presence => true,
    :length => { :in => 4..20 },
    :uniqueness => { :case_sensitive => false, :message => "is taken" }

  validates :password,
    presence: true,
    length: { minimum: 8 }
end
