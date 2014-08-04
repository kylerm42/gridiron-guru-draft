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

require 'rails_helper'

RSpec.describe League, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
