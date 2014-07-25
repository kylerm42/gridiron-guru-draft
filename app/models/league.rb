# == Schema Information
#
# Table name: leagues
#
#  id              :integer          not null, primary key
#  name            :string(255)      not null
#  manager_id      :integer          not null
#  number_of_teams :integer          default(10), not null
#  password_digest :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class League < ActiveRecord::Base
  validates :name, :manager_id, :number_of_teams, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  belongs_to :manager, class_name: "User"

  attr_reader :password

  def password=(secret)
    @password = secret
    self.password_digest = BCrypt::Password.create(secret)
  end

  def password_is?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end
end
