# == Schema Information
#
# Table name: leagues
#
#  id              :integer          not null, primary key
#  name            :string(255)      not null
#  tagline         :string(255)
#  manager_id      :integer          not null
#  number_of_teams :integer          default(10), not null
#  password_digest :string(255)      not null
#  activation_key  :string(255)      not null
#  positions       :hstore           not null
#  created_at      :datetime
#  updated_at      :datetime
#

class League < ActiveRecord::Base
  after_initialize :set_default_attributes
  before_save :fill_league_teams

  validates :name, :manager_id, :number_of_teams, :activation_key, :positions, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  belongs_to :manager, class_name: "User"
  has_many   :teams
  has_many   :owners,
             through: :teams,
             source: :owner

  attr_reader :password

  POSITION_NAMES = ['QB', 'RB', 'WR', 'TE', 'RB/WR/TE', 'K', 'DEF', 'BN']

  def password=(secret)
    @password = secret
    self.password_digest = BCrypt::Password.create(secret)
  end

  def password_is?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  private

    def set_default_attributes
      self.number_of_teams ||= 10
      self.activation_key ||= SecureRandom.urlsafe_base64
      self.positions ||= {
        "QB" => 1,
        "RB" => 2,
        "WR" => 2,
        "TE" => 1,
        "RB/WR/TE" => 1,
        "K" => 1,
        "DEF" => 1,
        "BN" => 6
      }
    end

    def fill_league_teams
      (number_of_teams - teams.count).times do |idx|
        teams.build(name: "Team #{idx}", draft_slot: idx, owner: manager)
      end
    end
end
