# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  token      :string(255)
#  user_id    :integer
#  device     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Session, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
