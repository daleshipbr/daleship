class User < ApplicationRecord

  attr_accessor :remember_token, :reset_token

  belongs_to :company
  has_many :freights

  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :password, presence: true, length: { minimum: 8, maximum: 255 }
  validates :job_title, presence: true, length: { maximum: 255 }
  validates :user_type, presence: true, inclusion: { in: ["shipper", "carrier"] }

  # implementar email de boas vindas
  # after_commit -> { UserMailer.welcome(self).deliver_later }, on: :create

  has_secure_password

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update(remember_digest: nil,
           facebook_token: nil,
           facebook_expires_at: nil,
           google_token: nil,
           google_expires_at: nil)
  end

  def reset
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    reset
    UserMailer.password_reset(self, reset_token).deliver_later
  end

  def password_reset_expired?
    reset_sent_at < 24.hours.ago
  end
end
