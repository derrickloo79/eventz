class User < ApplicationRecord
  before_save :set_slug
  
  has_secure_password
  has_many :registrations, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_events, through: :likes, source: :event

  validates :name, presence: true, uniqueness: true
  validates :username, format: { with: /\A[A-Z0-9]+\z/i }, uniqueness: { case_sensitive: false }
  validates :email, format: { with: /\S+@\S+/ }, uniqueness: { case_sensitive: false }

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end

  def to_param
    slug
  end

private

  def set_slug
    self.slug = name.parameterize
  end
end
