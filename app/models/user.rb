class User < ApplicationRecord
  has_many :articles
  # has_secure_password

  validates :email, 
    format: { with: URI::MailTo::EMAIL_REGEXP },
    :uniqueness => { :case_sensitive => true, :message => "is taken" }

  validates :username, 
    :presence => true,
    :length => { :in => 4..20 },
    :uniqueness => { :case_sensitive => false, :message => "is taken" }
end
