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

require 'rails_helper'

RSpec.describe Team, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
