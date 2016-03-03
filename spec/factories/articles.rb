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

FactoryGirl.define do
  factory :article, class: Article do
    title 'Android Engineer'
    body 'Ruby on Rails'
  end
end
