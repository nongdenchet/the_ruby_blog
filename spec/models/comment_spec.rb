# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  article_id :integer
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should respond_to(:user) }
  it { should respond_to(:user_id) }
  it { should respond_to(:article) }
  it { should respond_to(:article_id) }
  it { should respond_to(:content) }
  it { should validate_presence_of(:content) }
end
