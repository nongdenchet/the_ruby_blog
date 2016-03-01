# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Article < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true, length: {minimum: 8}
  validates :body, presence: true, length: {minimum: 8}
  validates :user_id, presence: true
end
