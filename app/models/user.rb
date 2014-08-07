# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  first_name      :string(255)      not null
#  last_name       :string(255)      not null
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates :username, :email, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many :sessions
  has_many :teams,
           foreign_key: :owner_id
  has_many :managed_leagues,
           foreign_key: :manager_id,
           class_name: "League"
  has_many :leagues,
           through: :teams,
           source: :league

  attr_reader :password

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    user && user.password_is?(password) ? user : nil
  end

  def password=(secret)
    @password = secret
    self.password_digest = BCrypt::Password.create(secret)
  end

  def password_is?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def leagues
    super.distinct
  end
end
