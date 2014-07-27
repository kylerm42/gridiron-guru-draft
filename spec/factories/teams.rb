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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do
    name "MyString"
    owner_id 1
    league nil
    draft_slot 1
  end
end
