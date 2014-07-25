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

class Session < ActiveRecord::Base
  validates :token, presence: true, uniqueness: true
  validates :user, presence: true
  # validates :device, uniqueness: { scope: :user }

  belongs_to :user
end
