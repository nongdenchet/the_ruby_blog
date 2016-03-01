# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:articles) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  before(:each) do
    @user = build(:user)
  end

  it 'email should not be invalid' do
    @user.email = 'email'
    expect(@user.valid?).to be_falsey
  end

  it 'email should not be blank' do
    @user.email = ''
    expect(@user.valid?).to be_falsey
  end

  it 'password should not be blank' do
    @user.password = ''
    expect(@user.valid?).to be_falsey
  end

  it 'password should have at least 8 characters' do
    @user.password = '1234'
    expect(@user.valid?).to be_falsey
  end

  it 'password and confirmation should match' do
    @user.password = '12345678'
    @user.password_confirmation = '12345678910'
    expect(@user.valid?).to be_falsey
  end

  it 'valid user' do
    expect(@user.valid?).to be_truthy
  end
end
