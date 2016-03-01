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

require 'rails_helper'

RSpec.describe Article, type: :model do
  it { should belong_to(:user) }
  it { should respond_to(:title) }
  it { should respond_to(:body) }
  it { should respond_to(:user) }
  it { should respond_to(:user_id) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:user_id) }
  it { should validate_length_of(:title).is_at_least(8) }
  it { should validate_length_of(:body).is_at_least(8) }
end
