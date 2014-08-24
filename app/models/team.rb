# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  owner_id   :integer
#  league_id  :integer          not null
#  draft_slot :integer          not null
#  color      :string(255)      default("007DBD"), not null
#  created_at :datetime
#  updated_at :datetime
#

class Team < ActiveRecord::Base
  after_initialize :set_default_attributes

  validates :name, :league, :draft_slot, :color, presence: true
  # validates :draft_slot, uniqueness: { scope: :league_id }
  validates :color, format: { with: /\A([\h]{6}|[\h]{3})\Z/i,
                              message: 'must be in valid hex format' }
  validate :draft_slot_in_range

  belongs_to :league
  belongs_to :owner, class_name: "User"
  has_many   :draft_picks

  def color=(hex)
    write_attribute(:color, hex.to_s.upcase)
  end

  private

    def set_default_attributes
      self.draft_slot ||= league.open_draft_slots.min
      self.color ||= '1192D3'
    end

    def draft_slot_in_range
      unless league && (1..league.number_of_teams).include?(draft_slot)
        errors.add(:draft_slot, 'must be within range of total teams')
      end
    end
end

