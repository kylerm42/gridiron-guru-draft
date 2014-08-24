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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :draft_pick do
    team nil
    player nil
    round 1
  end
end
