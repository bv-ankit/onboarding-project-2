class User < ApplicationRecord
  has_many :articles
  has_secure_password

  attr_accessor :remember_token

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

  class << self
    def digest(string)
      (cost = ActiveModel::SecurePassword.min_cost) ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
