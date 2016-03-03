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
#  view_count :integer          default(0)
#

class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  validates :title, presence: true, length: {minimum: 8}
  validates :body, presence: true, length: {minimum: 8}
  validates :user_id, presence: true
  validates :view_count, presence: true, numericality: {only_integer: true}

  def increase_view_count
    self.view_count += 1
    self.save
  end
end
