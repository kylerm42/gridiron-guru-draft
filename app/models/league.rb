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
  before_save :verify_draft_order

  validates :name, :manager_id, :number_of_teams, :activation_key, :positions, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  belongs_to :manager,
             class_name: "User"
  has_many   :owners,
             through:    :teams,
             source:     :owner
  has_many   :teams,
             dependent:  :destroy do
    
    def update(team_params)
      Team.transaction do
        team_params.each do |id, attributes|
          team = Team.find(id)
          team.update(attributes) if self.include?(team)
        end
      end
    end
  end

  attr_reader :password

  POSITION_NAMES = ['QB', 'RB', 'WR', 'TE', 'RB/WR/TE', 'K', 'DEF', 'BN']

  def teams
    persisted? ? super.order(:draft_slot) : super
  end

  def password=(secret)
    @password = secret
    self.password_digest = BCrypt::Password.create(secret)
  end

  def password_is?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def full?
    teams.all?(&:owner)
  end

  def can_join?(password)
    if full?
      errors.add(:league, 'is full')
      false
    elsif password_is?(password)
      errors.add(:password, 'is invalid')
      false
    else
      true
    end     
  end

  def open_draft_slots
    (1..number_of_teams).to_a - teams.inject([]) { |draft_slots, team| draft_slots << team.draft_slot }
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
      number_of_teams.times do |idx|
        teams.build(name: "Team #{idx}", draft_slot: open_draft_slots.min)
      end

      teams.first.owner = manager
    end

    def verify_draft_order
      return if open_draft_slots.empty?

      teams.each_with_index do |team, idx|
        team.update_attributes(draft_slot: idx + 1)
      end
    end
end
