# == Schema Information
#
# Table name: draft_picks
#
#  id         :integer          not null, primary key
#  team_id    :integer
#  player_id  :integer
#  round      :integer
#  created_at :datetime
#  updated_at :datetime
#

class DraftPick < ActiveRecord::Base
  # Validations
  validates :team, :round, presence: true
  validate :player_avaliable?

  # Associations
  belongs_to :team
  belongs_to :player
  has_one    :league,
               through: :team,
               source: :league

  private

    def player_available?
      !league.drafted_players.include?(player)
    end
end
