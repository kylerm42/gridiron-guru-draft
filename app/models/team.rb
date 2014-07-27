# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  owner_id   :integer          not null
#  league_id  :integer          not null
#  draft_slot :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Team < ActiveRecord::Base
  before_save :set_default_attributes

  validates :name, :owner, :league, presence: true
  validates :draft_slot, uniqueness: { scope: :league_id },
                         inclusion: { in: 0..league.number_of_teams }

  belongs_to :league
  belongs_to :owner, class_name: "User"

  private

    def set_default_attributes
      draft_slot ||= league.teams.count
      owner = current_user
    end
end