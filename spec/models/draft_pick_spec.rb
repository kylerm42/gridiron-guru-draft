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

require 'rails_helper'

RSpec.describe DraftPick, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
